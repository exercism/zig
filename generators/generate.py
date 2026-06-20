#!/usr/bin/env python3
"""Zig track test generator.

Architecture:
  * This orchestrator owns everything generic: locating canonical data, flattening the
    case tree, honoring `reimplements`/unicode scenarios and `.meta/tests.toml`, appending
    `.meta/supplements.json`, wrapping each case in a `test "..." {}` block,
    assembling the import header, and running `zig fmt`.
  * generators/lib.py owns Zig value formatting (escaping, int grouping, slice literals).
  * generators/exercises/<slug>.py owns ONLY the per-case body and any exercise-specific
    header (helper fns / const aliases).

Per-exercise module surface (all optional except gen_case):
    USE_MEM = False           # add `const mem = std.mem;`
    IMPORT_SELF = True        # add `const <slug> = @import("<slug>.zig");`
    HEADER = ""               # extra lines after imports (const aliases, helper fns)
    def describe(case, parent): -> str        # custom test-name; default joins with '-'
    def gen_case(case): -> str                # body of the test block (required)

Usage:
    bin/generate <slug> [<slug> ...]     # generate listed exercises
    bin/generate --all                   # generate every exercise with a module
    bin/generate --check <slug> ...      # verify generated file matches committed
"""

import argparse
import importlib
import json
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)

ZIG = "zig"


def read_canonical_data(slug):
    prefix = "Using cached 'problem-specifications' dir: "
    info = subprocess.run(
        ["bin/configlet", "info", "-o", "-v", "d"],
        capture_output=True,
        check=True,
        text=True,
        cwd=ROOT,
    ).stdout.split("\n")
    cache = [ln[len(prefix) :] for ln in info if ln.startswith(prefix)]
    if len(cache) != 1:
        raise SystemExit("Could not determine 'problem-specifications' dir")
    path = f"{cache[0]}/exercises/{slug}/canonical-data.json"
    with open(path) as f:
        return json.load(f)


def collect_reimplemented(data):
    """uuids to exclude: explicit `reimplements` targets + unicode-scenario cases."""
    out = set()

    def walk(node):
        if "cases" in node:
            for c in node["cases"]:
                walk(c)
        else:
            if "reimplements" in node:
                out.add(node["reimplements"])
            if "unicode" in node.get("scenarios", []):
                out.add(node["uuid"])

    walk(data)
    return out


def default_describe(case, parent):
    desc = case["description"]
    if parent:
        desc = f"{parent}-{desc}"
        desc = desc.replace("garden-garden", "garden")
    return desc


def flatten(data, mod, reimplemented, toml):
    """Flatten the case tree into leaf cases, attaching a joined `description`."""
    describe = getattr(mod, "describe", default_describe)
    leaves = []

    def walk(node, parent):
        desc = describe(node, parent)
        if "cases" in node:
            for c in node["cases"]:
                walk(c, desc)
            return
        uuid = node.get("uuid")
        if uuid in reimplemented:
            return
        if toml.get(uuid, {}).get("include", True) is False:
            return
        leaves.append({**node, "description": desc})

    for node in data["cases"]:
        # top-level group nodes may lack a uuid
        walk(node, None)
    return leaves


def load_toml(slug):
    path = f"{ROOT}/exercises/practice/{slug}/.meta/tests.toml"
    if not os.path.exists(path):
        return {}
    try:
        import tomllib
    except ModuleNotFoundError:
        import tomli as tomllib
    with open(path, "rb") as f:
        return tomllib.load(f)


def load_supplements(slug):
    path = f"{ROOT}/exercises/practice/{slug}/.meta/supplements.json"
    if not os.path.exists(path):
        return []
    with open(path) as f:
        return json.load(f).get("cases", [])


def render(slug, mod, leaves):
    us = slug.replace("-", "_")
    parts = ['const std = @import("std");\n']
    if getattr(mod, "USE_MEM", False):
        parts.append("const mem = std.mem;\n")
    parts.append("const testing = std.testing;\n\n")
    if getattr(mod, "IMPORT_SELF", True):
        parts.append(f'const {us} = @import("{us}.zig");\n')
    header = getattr(mod, "HEADER", "")
    if header:
        parts.append(header if header.endswith("\n") else header + "\n")
    body = "".join(parts)
    for case in leaves:
        inner = mod.gen_case(case)
        body += "\n" + f'test "{case["description"]}" ' + "{\n" + inner
        if not inner.endswith("\n"):
            body += "\n"
        body += "}\n"
    return body


def zig_fmt(text):
    try:
        r = subprocess.run(
            [ZIG, "fmt", "--stdin"], input=text, capture_output=True, text=True
        )
        if r.returncode == 0:
            return r.stdout
        sys.stderr.write(
            f"warning: `zig fmt` failed, writing unformatted:\n{r.stderr}\n"
        )
    except FileNotFoundError:
        sys.stderr.write("warning: `zig` not found; writing unformatted\n")
    return text


def generate(slug, check=False):
    mod = importlib.import_module("exercises." + slug.replace("-", "_"))
    data = read_canonical_data(slug)
    reimplemented = collect_reimplemented(data)
    leaves = flatten(data, mod, reimplemented, load_toml(slug))
    for extra in load_supplements(slug):
        # supplements may themselves be nested groups
        def walk(node, parent):
            desc = getattr(mod, "describe", default_describe)(node, parent)
            if "cases" in node:
                for c in node["cases"]:
                    walk(c, desc)
            else:
                leaves.append({**node, "description": desc})

        walk(extra, None)

    # Supplements always append after canonical cases; an optional `order_key` lets a
    # module re-sort the combined list into a more natural order (stable sort).
    if hasattr(mod, "order_key"):
        leaves.sort(key=mod.order_key)

    text = zig_fmt(render(slug, mod, leaves))
    us = slug.replace("-", "_")
    out = f"{ROOT}/exercises/practice/{slug}/test_{us}.zig"
    if check:
        existing = open(out).read() if os.path.exists(out) else ""
        if existing != text:
            print(f"DRIFT: {slug}")
            return False
        print(f"ok: {slug}")
        return True
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, "w") as f:
        f.write(text)
    print(f"generated: exercises/practice/{slug}/test_{us}.zig")
    return True


def all_slugs():
    d = f"{HERE}/exercises"
    return sorted(
        f[:-3].replace("_", "-")
        for f in os.listdir(d)
        if f.endswith(".py") and f != "__init__.py"
    )


def main():
    p = argparse.ArgumentParser()
    p.add_argument("slugs", nargs="*")
    p.add_argument("--all", action="store_true")
    p.add_argument("--check", action="store_true")
    args = p.parse_args()
    slugs = all_slugs() if args.all else args.slugs
    if not slugs:
        p.error("provide exercise slug(s) or --all")
    ok = True
    for slug in slugs:
        try:
            ok = generate(slug, check=args.check) and ok
        except Exception as e:
            ok = False
            print(f"ERROR {slug}: {e}", file=sys.stderr)
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
