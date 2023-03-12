const std = @import("std");
const testing = std.testing;

const hamming = @import("hamming.zig");
const DnaError = hamming.DnaError;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "empty strands" {
    const expected = DnaError.EmptyDnaStrands;
    const actual = hamming.compute("", "");
    try testing.expectError(expected, actual);
}

test "single letter identical strands" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 0;
    const actual = try hamming.compute("A", "A");
    try testing.expectEqual(expected, actual);
}

test "single letter different strands" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 1;
    const actual = try hamming.compute("G", "T");
    try testing.expectEqual(expected, actual);
}

test "long identical strands" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 0;
    const actual = try hamming.compute("GGACTGAAATCTG", "GGACTGAAATCTG");
    try testing.expectEqual(expected, actual);
}

test "long different strands" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 9;
    const actual = try hamming.compute("GGACGGATTCTG", "AGGACGGATTCT");
    try testing.expectEqual(expected, actual);
}

test "disallow first strand longer" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = DnaError.UnequalDnaStrands;
    const actual = hamming.compute("AATG", "AAA");
    try testing.expectError(expected, actual);
}

test "disallow second strand longer" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = DnaError.UnequalDnaStrands;
    const actual = hamming.compute("ATA", "AGTG");
    try testing.expectError(expected, actual);
}

test "disallow left empty strand" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = DnaError.EmptyDnaStrands;
    const actual = hamming.compute("", "G");
    try testing.expectError(expected, actual);
}

test "disallow right empty strand" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = DnaError.EmptyDnaStrands;
    const actual = hamming.compute("G", "");
    try testing.expectError(expected, actual);
}
