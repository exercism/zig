const std = @import("std");
const testing = std.testing;

const isogram = @import("isogram.zig");

test "empty string" {
    try testing.expect(isogram.isIsogram(""));
}

test "isogram with only lower case characters" {
    try testing.expect(isogram.isIsogram("isogram"));
}

test "word with one duplicated character" {
    try testing.expect(!isogram.isIsogram("eleven"));
}

test "word with one duplicated character from the end of the alphabet" {
    try testing.expect(!isogram.isIsogram("zzyzx"));
}

test "longest reported english isogram" {
    try testing.expect(isogram.isIsogram("subdermatoglyphic"));
}

test "word with duplicated character in mixed case" {
    try testing.expect(!isogram.isIsogram("Alphabet"));
}

test "word with duplicated character in mixed case, lowercase first" {
    try testing.expect(!isogram.isIsogram("alphAbet"));
}

test "hypothetical isogrammic word with hyphen" {
    try testing.expect(isogram.isIsogram("thumbscrew-japingly"));
}

test "hypothetical word with duplicated character following hyphen" {
    try testing.expect(!isogram.isIsogram("thumbscrew-jappingly"));
}

test "isogram with duplicated hyphen" {
    try testing.expect(isogram.isIsogram("six-year-old"));
}

test "made-up name that is an isogram" {
    try testing.expect(isogram.isIsogram("Emily Jung Schwartzkopf"));
}

test "duplicated character in the middle" {
    try testing.expect(!isogram.isIsogram("accentor"));
}

test "same first and last characters" {
    try testing.expect(!isogram.isIsogram("angola"));
}

test "word with duplicated character and with two hyphens" {
    try testing.expect(!isogram.isIsogram("up-to-date"));
}
