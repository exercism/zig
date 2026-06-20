from lib import zstr

IMPORT_SELF = False

HEADER = 'const response = @import("bob.zig").response;'


def gen_case(case):
    s = case["input"]["heyBob"]
    expected = case["expected"]
    return (
        f"    const expected = {zstr(expected)};\n"
        f"    const actual = response({zstr(s)});\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
