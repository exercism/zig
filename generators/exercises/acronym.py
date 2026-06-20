from lib import zstr

IMPORT_SELF = False

HEADER = 'const abbreviate = @import("acronym.zig").abbreviate;'


def gen_case(case):
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    return (
        f"    const expected = {zstr(expected)};\n"
        f"    const actual = try abbreviate(testing.allocator, {zstr(phrase)});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
