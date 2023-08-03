const std = @import("std");
const testing = std.testing;

const reverse_string = @import("reverse_string.zig");

fn testReverse(comptime s: []const u8, expected: []const u8) !void {
    var buffer: [s.len]u8 = undefined;
    const actual = reverse_string.reverse(&buffer, s);
    try testing.expectEqualStrings(expected, actual);
}

test "an empty string" {
    try testReverse("", "");
}

test "a word" {
    try testReverse("robot", "tobor");
}

test "a capitalized word" {
    try testReverse("Ramen", "nemaR");
}

test "a sentence with punctuation" {
    try testReverse("I'm hungry!", "!yrgnuh m'I");
}

test "a palindrome" {
    try testReverse("racecar", "racecar");
}

test "an even-sized word" {
    try testReverse("drawer", "reward");
}
