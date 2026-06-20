# Zig test generator

Generates `exercises/practice/<slug>/test_<slug>.zig` files from the shared
[problem-specifications](https://github.com/exercism/problem-specifications)
`canonical-data.json`.

## Usage

Run from the repo root:

```bash
bin/generate <slug> [<slug> ...]   # generate specific exercises
bin/generate --all                 # generate every exercise that has a module
bin/generate --check <slug> ...    # CI: verify committed files are up to date (no write)
```

`zig` must be on `PATH` (or set `ZIG=/path/to/zig`); the output is run through `zig fmt`.

## Architecture

Three layers, so per-exercise code stays tiny and consistent:

- **`generate.py`** — the orchestrator. Owns everything generic: locating canonical data
  (via `bin/configlet`), flattening the case tree, joining nested descriptions
  (`parent-child`), excluding cases (`reimplements`, unicode `scenarios`, and
  `tests.toml` `include = false`), appending
  `.meta/supplements.json` cases, wrapping each case as `test "<desc>" { ... }`, emitting
  the import header, and running `zig fmt`.
- **`lib.py`** — shared Zig value formatters: `zstr` (fully-escaped string literal),
  `zint` (`_`-grouped int), `zbool`, `zfloat`, `zmultiline`, `zslice`/`zarray`/`zint_slice`,
  and `is_error`. Use these instead of hand-rolling escaping or literals.
- **`exercises/<slug>.py`** — one module per exercise, supplying only the exercise-specific
  parts.

## Writing an exercise module

```python
# generators/exercises/<underscored_slug>.py
from lib import zstr, zint, is_error   # whatever you need

USE_MEM = False        # set True to add `const mem = std.mem;`
IMPORT_SELF = True     # default adds `const <slug> = @import("<slug>.zig");`
HEADER = ""            # extra lines after imports: const aliases + helper fns

def describe(case, parent):     # OPTIONAL: override description joining
    return case["description"]   # e.g. exercises that must not join the group name

def gen_case(case):             # REQUIRED
    # case = {"property", "description", "input", "expected", "uuid"}
    # return the BODY of the test block; zig fmt fixes indentation.
    n = case["input"]["number"]
    return f"    try testing.expectEqual({case['expected']}, foo.bar({n}));\n"
```

Conventions:

- Always format strings with `zstr` and grouped ints with `zint`.
- Put `const X = <slug>.X;` aliases and any test helper `fn`s in `HEADER`.
- Map error cases (`is_error(expected)`) to `testing.expectError(<Err>, <call>)` using the
  error set from the exercise's `example.zig`.

## Extra (track-specific) tests

Cases beyond canonical data live in `exercises/practice/<slug>/.meta/supplements.json`
(factor-style):

```json
{ "cases": [ { "description": "...", "property": "...", "input": { ... }, "expected": ... } ] }
```
