from lib import zstr

IMPORT_SELF = True
HEADER = "const DnaError = hamming.DnaError;\n"

# Canonical reimplements rename the empty-strand cases to "first/second"; the
# committed target keeps the original "left/right" wording.
_RENAME = {
    "disallow empty first strand": "disallow left empty strand",
    "disallow empty second strand": "disallow right empty strand",
}


def describe(case, parent):
    return _RENAME.get(case["description"], case["description"])


def gen_case(case):
    s1 = case["input"]["strand1"]
    s2 = case["input"]["strand2"]
    a = zstr(s1)
    b = zstr(s2)
    if len(s1) == 0 or len(s2) == 0:
        return (
            "    const expected = DnaError.EmptyDnaStrands;\n"
            f"    const actual = hamming.compute({a}, {b});\n"
            "    try testing.expectError(expected, actual);\n"
        )
    if len(s1) != len(s2):
        return (
            "    const expected = DnaError.UnequalDnaStrands;\n"
            f"    const actual = hamming.compute({a}, {b});\n"
            "    try testing.expectError(expected, actual);\n"
        )
    e = case["expected"]
    return (
        f"    const expected: usize = {e};\n"
        f"    const actual = try hamming.compute({a}, {b});\n"
        "    try testing.expectEqual(expected, actual);\n"
    )
