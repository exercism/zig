from lib import zstr

HEADER = "const format = line_up.format;\n"


def gen_case(case):
    name = case["input"]["name"]
    number = case["input"]["number"]
    expected = case["expected"]
    return (
        f"    const expected: []const u8 = {zstr(expected)};\n"
        f"    const actual = try format(testing.allocator, {zstr(name)}, {number});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
