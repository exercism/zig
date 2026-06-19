from lib import zstr


def gen_case(case):
    plaintext = zstr(case["input"]["plaintext"])
    e = zstr(case["expected"])
    return (
        f"    const expected: []const u8 = {e};\n"
        f"    const actual = try crypto_square.ciphertext(testing.allocator, {plaintext});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
