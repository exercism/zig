from lib import zstr


def gen_case(case):
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    return (
        f"    const expected: []const u8 = {zstr(expected)};\n"
        f"    const actual = try pig_latin.translate(testing.allocator, {zstr(phrase)});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
