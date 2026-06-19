from lib import zstr, is_error

HEADER = (
    "const encode = affine_cipher.encode;\n"
    "const decode = affine_cipher.decode;\n"
    "const AffineCipherError = affine_cipher.AffineCipherError;"
)


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
        return (
            f"    const actual = {prop}(testing.allocator, {phrase}, {a}, {b});\n"
            f"    try testing.expectError(AffineCipherError.NotCoprime, actual);\n"
        )

    return (
        f"    const expected: []const u8 = {zstr(e)};\n"
        f"    const actual = try {prop}(testing.allocator, {phrase}, {a}, {b});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
