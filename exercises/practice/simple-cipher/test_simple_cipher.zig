const std = @import("std");
const testing = std.testing;

const simple_cipher = @import("simple_cipher.zig");
const Cipher = simple_cipher.Cipher;

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

test "Random key cipher-Can encode" {
    const phrase: []const u8 = "aaaaaaaaaa";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ null, .encode, phrase, null },
    );
}

test "Random key cipher-Can decode" {
    const expect: []const u8 = "aaaaaaaaaa";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ null, .decode, null, expect },
    );
}

test "Random key cipher-Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method" {
    const phrase: []const u8 = "abcdefghij";
    const expect: []const u8 = "abcdefghij";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ null, .round_trip, phrase, expect },
    );
}

test "Random key cipher-Key is made only of lowercase letters" {
    try testing.checkAllAllocationFailures(testing.allocator, testKey, .{});
}

test "Substitution cipher-Can encode" {
    const phrase: []const u8 = "aaaaaaaaaa";
    const expect: []const u8 = "abcdefghij";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abcdefghij", .encode, phrase, expect },
    );
}

test "Substitution cipher-Can decode" {
    const phrase: []const u8 = "abcdefghij";
    const expect: []const u8 = "aaaaaaaaaa";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abcdefghij", .decode, phrase, expect },
    );
}

test "Substitution cipher-Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method" {
    const phrase: []const u8 = "abcdefghij";
    const expect: []const u8 = "abcdefghij";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abcdefghij", .round_trip, phrase, expect },
    );
}

test "Substitution cipher-Can double shift encode" {
    const phrase: []const u8 = "iamapandabear";
    const expect: []const u8 = "qayaeaagaciai";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "iamapandabear", .encode, phrase, expect },
    );
}

test "Substitution cipher-Can wrap on encode" {
    const phrase: []const u8 = "zzzzzzzzzz";
    const expect: []const u8 = "zabcdefghi";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abcdefghij", .encode, phrase, expect },
    );
}

test "Substitution cipher-Can wrap on decode" {
    const phrase: []const u8 = "zabcdefghi";
    const expect: []const u8 = "zzzzzzzzzz";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abcdefghij", .decode, phrase, expect },
    );
}

test "Substitution cipher-Can encode messages longer than the key" {
    const phrase: []const u8 = "iamapandabear";
    const expect: []const u8 = "iboaqcnecbfcr";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abc", .encode, phrase, expect },
    );
}

test "Substitution cipher-Can decode messages longer than the key" {
    const phrase: []const u8 = "iboaqcnecbfcr";
    const expect: []const u8 = "iamapandabear";
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testCipher,
        .{ "abc", .decode, phrase, expect },
    );
}
