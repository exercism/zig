const std = @import("std");
const testing = std.testing;

const crypto_square = @import("crypto_square.zig");

test "empty plaintext results in an empty ciphertext" {
    const expected: []const u8 = "";
    const actual = try crypto_square.ciphertext(testing.allocator, "");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "normalization results in empty plaintext" {
    const expected: []const u8 = "";
    const actual = try crypto_square.ciphertext(testing.allocator, "... --- ...");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "Lowercase" {
    const expected: []const u8 = "a";
    const actual = try crypto_square.ciphertext(testing.allocator, "A");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "Remove spaces" {
    const expected: []const u8 = "b";
    const actual = try crypto_square.ciphertext(testing.allocator, "  b ");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "Remove punctuation" {
    const expected: []const u8 = "1";
    const actual = try crypto_square.ciphertext(testing.allocator, "@1,%!");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "9 character plaintext results in 3 chunks of 3 characters" {
    const expected: []const u8 = "tsf hiu isn";
    const actual = try crypto_square.ciphertext(testing.allocator, "This is fun!");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "8 character plaintext results in 3 chunks, the last one with a trailing space" {
    const expected: []const u8 = "clu hlt io ";
    const actual = try crypto_square.ciphertext(testing.allocator, "Chill out.");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "54 character plaintext results in 8 chunks, the last two with trailing spaces" {
    const expected: []const u8 = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ";
    const actual = try crypto_square.ciphertext(testing.allocator, "If man was meant to stay on the ground, god would have given us roots.");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
