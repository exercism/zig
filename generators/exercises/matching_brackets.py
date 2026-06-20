from lib import zstr

IMPORT_SELF = False

HEADER = 'const isBalanced = @import("matching_brackets.zig").isBalanced;'


def gen_case(case):
    value = case["input"]["value"]
    expected = case["expected"]
    neg = "" if expected else "!"
    lit = zstr(value)
    # Inputs with backslashes or underscores (the latex and deeply-nested cases) are
    # hoisted into a `const s` to keep the call readable, matching the target test file.
    if "\\" in value or "_" in value:
        return (
            f"    const s = {lit};\n"
            f"    const actual = try isBalanced(testing.allocator, s);\n"
            f"    try testing.expect({neg}actual);\n"
        )
    return (
        f"    const actual = try isBalanced(testing.allocator, {lit});\n"
        f"    try testing.expect({neg}actual);\n"
    )
