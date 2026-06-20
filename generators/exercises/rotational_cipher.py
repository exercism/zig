from lib import zstr, zint


def gen_case(case):
    text = case["input"]["text"]
    shift = case["input"]["shiftKey"]
    expected = case["expected"]
    return (
        f"    const expected: []const u8 = {zstr(expected)};\n"
        f"    const actual = try rotational_cipher.rotate(testing.allocator, {zstr(text)}, {zint(shift)});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
