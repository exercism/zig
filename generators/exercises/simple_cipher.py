from lib import zstr

HEADER = """const Cipher = simple_cipher.Cipher;

const Op = enum { encode, decode, round_trip };

/// Applies `op` to `phrase` and checks that the result equals `expect`.
/// The cipher uses `key`, or a randomly generated key when `key` is null;
/// a null `phrase` or `expect` stands for a prefix of the random key.
fn testCipher(
    allocator: std.mem.Allocator,
    key: ?[]const u8,
    op: Op,
    phrase_opt: ?[]const u8,
    expect_opt: ?[]const u8,
) !void {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    var cipher = if (key) |k|
        try Cipher.init(allocator, k)
    else
        try Cipher.initRandom(allocator, prng.random());
    defer cipher.deinit(allocator);
    const phrase = phrase_opt orelse cipher.key[0..expect_opt.?.len];
    const expect = expect_opt orelse cipher.key[0..phrase_opt.?.len];
    switch (op) {
        .encode => {
            const actual = try cipher.encode(allocator, phrase);
            defer allocator.free(actual);
            try testing.expectEqualStrings(expect, actual);
        },
        .decode => {
            const actual = try cipher.decode(allocator, phrase);
            defer allocator.free(actual);
            try testing.expectEqualStrings(expect, actual);
        },
        .round_trip => {
            const encoded = try cipher.encode(allocator, phrase);
            defer allocator.free(encoded);
            const actual = try cipher.decode(allocator, encoded);
            defer allocator.free(actual);
            try testing.expectEqualStrings(expect, actual);
        },
    }
}

/// Checks that a random key is at least 100 lowercase letters.
fn testKey(allocator: std.mem.Allocator) !void {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    var cipher = try Cipher.initRandom(allocator, prng.random());
    defer cipher.deinit(allocator);
    try testing.expect(cipher.key.len >= 100);
    for (cipher.key) |letter| {
        try testing.expect(std.ascii.isLower(letter));
    }
}
"""


def gen_case(case):
    inp = case["input"]

    if case["property"] == "key":
        return "    try testing.checkAllAllocationFailures(testing.allocator, testKey, .{});\n"

    key = zstr(inp["key"]) if "key" in inp else "null"

    if inp.get("ciphertext") == "cipher.encode":
        # Round trip: decode(encode(phrase)) == phrase.
        op = ".round_trip"
        phrase = zstr(inp["plaintext"])
        expect = zstr(case["expected"])
    elif case["property"] == "encode":
        op = ".encode"
        phrase = zstr(inp["plaintext"])
        e = case["expected"]
        # A symbolic expected value refers to a prefix of the random key.
        expect = "null" if e.startswith("cipher.key") else zstr(e)
    else:
        op = ".decode"
        ciphertext = inp["ciphertext"]
        # A symbolic ciphertext refers to a prefix of the random key.
        phrase = "null" if ciphertext.startswith("cipher.key") else zstr(ciphertext)
        expect = zstr(case["expected"])

    out = []
    if phrase != "null":
        out.append(f"    const phrase: []const u8 = {phrase};\n")
        phrase = "phrase"
    if expect != "null":
        out.append(f"    const expect: []const u8 = {expect};\n")
        expect = "expect"
    out.append(
        "    try testing.checkAllAllocationFailures(\n"
        "        testing.allocator,\n"
        "        testCipher,\n"
        f"        .{{ {key}, {op}, {phrase}, {expect} }},\n"
        "    );\n"
    )
    return "".join(out)
