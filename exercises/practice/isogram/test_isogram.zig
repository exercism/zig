const std = @import("std");
const testing = std.testing;

const isogram = @import("isogram.zig");

fn testIsIsogram(phrase: []const u8, expected: bool) !void {
    try testing.expectEqual(expected, isogram.isIsogram(phrase));
}

test "empty string" {
    try testIsIsogram("", true);
}

test "isogram with only lower case characters" {
    try testIsIsogram("isogram", true);
}

test "word with one duplicated character" {
    try testIsIsogram("eleven", false);
}

test "word with one duplicated character from the end of the alphabet" {
    try testIsIsogram("zzyzx", false);
}

test "longest reported english isogram" {
    try testIsIsogram("subdermatoglyphic", true);
}

test "word with duplicated character in mixed case" {
    try testIsIsogram("Alphabet", false);
}

test "word with duplicated character in mixed case, lowercase first" {
    try testIsIsogram("alphAbet", false);
}

test "hypothetical isogrammic word with hyphen" {
    try testIsIsogram("thumbscrew-japingly", true);
}

test "hypothetical word with duplicated character following hyphen" {
    try testIsIsogram("thumbscrew-jappingly", false);
}

test "isogram with duplicated hyphen" {
    try testIsIsogram("six-year-old", true);
}

test "made-up name that is an isogram" {
    try testIsIsogram("Emily Jung Schwartzkopf", true);
}

test "duplicated character in the middle" {
    try testIsIsogram("accentor", false);
}

test "same first and last characters" {
    try testIsIsogram("angola", false);
}

test "word with duplicated character and with two hyphens" {
    try testIsIsogram("up-to-date", false);
}
