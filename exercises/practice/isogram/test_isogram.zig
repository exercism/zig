const std = @import("std");
const testing = std.testing;

const isogram = @import("isogram.zig");

test "empty string" {
    testing.expect(isogram.isIsogram(""));
}

test "isogram with only lower case characters" {
    testing.expect(isogram.isIsogram("isogram"));
}

test "word with one duplicated character" {
    testing.expect(!isogram.isIsogram("eleven"));
}

test "word with one duplicated character from the end of the alphabet" {
    testing.expect(!isogram.isIsogram("zzyzx"));
}

test "word with one duplicated character from the end of the alphabet" {
    testing.expect(isogram.isIsogram("subdermatoglyphic"));
}

test "word with duplicated character in mixed case" {
    testing.expect(!isogram.isIsogram("Alphabet"));
}

test "word with duplicated character in mixed case, lowercase first" {
    testing.expect(!isogram.isIsogram("alphAbet"));
}

test "hypothetical isogrammic word with hyphen" {
    testing.expect(isogram.isIsogram("thumbscrew-japingly"));
}

test "hypothetical word with duplicated character following hyphen" {
    testing.expect(!isogram.isIsogram("thumbscrew-jappingly"));
}

test "isogram with duplicated hyphen" {
    testing.expect(isogram.isIsogram("six-year-old"));
}

test "made-up name that is an isogram" {
    testing.expect(isogram.isIsogram("Emily Jung Schwartzkopf"));
}

test "duplicated character in the middle" {
    testing.expect(!isogram.isIsogram("accentor"));
}

test "same first and last characters" {
    testing.expect(!isogram.isIsogram("angola"));
}
