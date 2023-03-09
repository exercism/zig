const std = @import("std");
const testing = std.testing;

const isogram = @import("isogram.zig");

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "empty string" {
    try testing.expect(isogram.isIsogram(""));
}

test "isogram with only lower case characters" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(isogram.isIsogram("isogram"));
}

test "word with one duplicated character" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("eleven"));
}

test "word with one duplicated character from the end of the alphabet" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("zzyzx"));
}

test "longest reported english isogram" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(isogram.isIsogram("subdermatoglyphic"));
}

test "word with duplicated character in mixed case" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("Alphabet"));
}

test "word with duplicated character in mixed case, lowercase first" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("alphAbet"));
}

test "hypothetical isogrammic word with hyphen" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(isogram.isIsogram("thumbscrew-japingly"));
}

test "hypothetical word with duplicated character following hyphen" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("thumbscrew-jappingly"));
}

test "isogram with duplicated hyphen" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(isogram.isIsogram("six-year-old"));
}

test "made-up name that is an isogram" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(isogram.isIsogram("Emily Jung Schwartzkopf"));
}

test "duplicated character in the middle" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("accentor"));
}

test "same first and last characters" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("angola"));
}

test "word with duplicated character and with two hyphens" {
    // Delete or comment out below line to run test
    try skipTest();

    try testing.expect(!isogram.isIsogram("up-to-date"));
}
