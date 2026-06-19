"""Shared Zig value formatters for the test generator.

This module owns every *language-level* value formatting primitive, so that per-exercise
modules never re-implement escaping, integer grouping, bool spelling, or slice literals.

A per-exercise module receives a `case` dict (keys: property, description, input,
expected, uuid) and returns the *body* of a `test "..." { ... }` block as a string.
`zig fmt` is run on the final file, so module output need not be perfectly indented.
"""


def zint(n):
    """Integer literal with Zig '_' digit grouping, e.g. 1_000_000.

    Matches the reference generator's f"{n:_}" formatting.
    """
    return format(int(n), "_")


def zbool(b):
    """Python bool -> Zig bool literal."""
    return "true" if b else "false"


def zfloat(x):
    """Float literal."""
    return repr(float(x))


# Characters needing escapes inside a Zig "..." string literal.
_STR_ESCAPES = {
    "\\": "\\\\",
    '"': '\\"',
    "\n": "\\n",
    "\r": "\\r",
    "\t": "\\t",
}


def zstr(s):
    """A double-quoted Zig string literal.

    Printable ASCII and printable Unicode are kept raw (Zig source is UTF-8, so a literal
    like "brühe" stays readable); only control characters and DEL are emitted as \\xNN
    escapes.
    """
    out = ['"']
    for ch in s:
        if ch in _STR_ESCAPES:
            out.append(_STR_ESCAPES[ch])
        elif 0x20 <= ord(ch) < 0x7F or ord(ch) >= 0xA0:
            out.append(ch)
        else:
            for b in ch.encode("utf-8"):
                out.append(f"\\x{b:02x}")
    out.append('"')
    return "".join(out)


def zcomment_list(elements):
    """Array body with one element per line, each followed by an empty `//` comment.

    The trailing `//` stops `zig fmt` from collapsing the array onto one line, so
    multi-line shapes (rectangle grids, slice lists) stay readable. Returns e.g.
    "{\\n    a, //\\n    b, //\\n}"; pair it with a `[_]T` prefix.
    """
    if not elements:
        return "{}"
    body = "".join(f"\n    {e}, //" for e in elements)
    return "{" + body + "\n}"


def zmultiline(s):
    """A Zig multiline string literal (``\\\\`` line prefixes) for text with newlines.

    Produces, for "a\\nb":
        \\\\a
        \\\\b
    Used by recitation-style exercises (bottle-song, etc.). No escaping of inner
    characters is needed in multiline literals except that each line is prefixed.
    """
    lines = s.split("\n")
    return "\n".join("\\\\" + line for line in lines)


def zslice(values, elem_ty="i32"):
    """A Zig slice literal: &[_]<elem_ty>{ a, b, c } (handles empty)."""
    if len(values) == 0:
        return f"&[_]{elem_ty}{{}}"
    inner = ", ".join(str(v) for v in values)
    return f"&[_]{elem_ty}{{ {inner} }}"


def zarray(values, elem_ty="i32"):
    """A by-value Zig array literal: [_]<elem_ty>{ a, b, c }."""
    if len(values) == 0:
        return f"[_]{elem_ty}{{}}"
    inner = ", ".join(str(v) for v in values)
    return f"[_]{elem_ty}{{ {inner} }}"


def zint_slice(values, elem_ty="i32"):
    """Slice literal from a list of ints, applying '_' grouping to each element."""
    return zslice([zint(v) for v in values], elem_ty)


def is_error(expected):
    """True if a canonical `expected` denotes an error case ({"error": "..."})."""
    return isinstance(expected, dict) and "error" in expected
