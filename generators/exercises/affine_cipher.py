from lib import zstr, is_error

HEADER = """const encode = affine_cipher.encode;
const decode = affine_cipher.decode;
const AffineCipherError = affine_cipher.AffineCipherError;

fn testEncodeError(phrase: []const u8, a: u8, b: u8) !void {
    const actual = encode(testing.allocator, phrase, a, b);
    defer if (actual) |slice| testing.allocator.free(slice) else |_| {};
    try testing.expectError(AffineCipherError.NotCoprime, actual);
}

fn testDecodeError(phrase: []const u8, a: u8, b: u8) !void {
    const actual = decode(testing.allocator, phrase, a, b);
    defer if (actual) |slice| testing.allocator.free(slice) else |_| {};
    try testing.expectError(AffineCipherError.NotCoprime, actual);
}
"""


def describe(case, parent):
    # No parent-description joining, for consistency with existing tests.
    return case["description"]


def gen_case(case):
    inp = case["input"]
    phrase = zstr(inp["phrase"])
    a = inp["key"]["a"]
    b = inp["key"]["b"]
    prop = case["property"]
    e = case["expected"]

    if is_error(e):
        helper = {"encode": "testEncodeError", "decode": "testDecodeError"}[prop]
        return f"    try {helper}({phrase}, {a}, {b});\n"

    return (
        f"    const expected: []const u8 = {zstr(e)};\n"
        f"    const actual = try {prop}(testing.allocator, {phrase}, {a}, {b});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
