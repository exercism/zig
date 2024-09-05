const std = @import("std");
const testing = std.testing;

const run_length_encoding = @import("run_length_encoding.zig");

fn testEncode(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer: [buffer_size]u8 = undefined;
    const actual = run_length_encoding.encode(&buffer, string);
    try testing.expectEqualStrings(expected, actual);
}

fn testDecode(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer: [buffer_size]u8 = undefined;
    const actual = run_length_encoding.decode(&buffer, string);
    try testing.expectEqualStrings(expected, actual);
}

fn testConsistency(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer1: [buffer_size]u8 = undefined;
    var buffer2: [buffer_size]u8 = undefined;
    const encoded = run_length_encoding.encode(&buffer1, string);
    const actual = run_length_encoding.decode(&buffer2, encoded);
    try testing.expectEqualStrings(expected, actual);
}

test "run-length encode a string-empty string" {
    try testEncode("", "");
}

test "run-length encode a string-single characters only are encoded without count" {
    try testEncode("XYZ", "XYZ");
}

test "run-length encode a string-string with no single characters" {
    try testEncode("AABBBCCCC", "2A3B4C");
}

test "run-length encode a string-single characters mixed with repeated characters" {
    try testEncode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB", "12WB12W3B24WB");
}

test "run-length encode a string-multiple whitespace mixed in string" {
    try testEncode("  hsqq qww  ", "2 hs2q q2w2 ");
}

test "run-length encode a string-lowercase characters" {
    try testEncode("aabbbcccc", "2a3b4c");
}

test "run-length decode a string-empty string" {
    try testDecode("", "");
}

test "run-length decode a string-single characters only" {
    try testDecode("XYZ", "XYZ");
}

test "run-length decode a string-string with no single characters" {
    try testDecode("2A3B4C", "AABBBCCCC");
}

test "run-length decode a string-single characters with repeated characters" {
    try testDecode("12WB12W3B24WB", "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB");
}

test "run-length decode a string-multiple whitespace mixed in string" {
    try testDecode("2 hs2q q2w2 ", "  hsqq qww  ");
}

test "run-length decode a string-lowercase string" {
    try testDecode("2a3b4c", "aabbbcccc");
}

test "encode and then decode-encode followed by decode gives original string" {
    try testConsistency("zzz ZZ  zZ", "zzz ZZ  zZ");
}
