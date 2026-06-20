IMPORT_SELF = False

HEADER = 'const toRoman = @import("roman_numerals.zig").toRoman;'


def gen_case(case):
    number = case["input"]["number"]
    expected = case["expected"]
    return (
        f'    const expected = "{expected}";\n'
        f"    const actual = try toRoman(testing.allocator, {number});\n"
        "    defer testing.allocator.free(actual);\n"
        "    try testing.expectEqualStrings(expected, actual);\n"
    )
