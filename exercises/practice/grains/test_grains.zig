const std = @import("std");
const testing = std.testing;

const grains = @import("grains.zig");
const ChessboardError = grains.ChessboardError;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "grains on square 1" {
    const expected: u64 = 1;
    const actual = try grains.square(1);
    try testing.expectEqual(expected, actual);
}

test "grains on square 2" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 2;
    const actual = try grains.square(2);
    try testing.expectEqual(expected, actual);
}

test "grains on square 3" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 4;
    const actual = try grains.square(3);
    try testing.expectEqual(expected, actual);
}

test "grains on square 4" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 8;
    const actual = try grains.square(4);
    try testing.expectEqual(expected, actual);
}

test "grains on square 16" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 32_768;
    const actual = try grains.square(16);
    try testing.expectEqual(expected, actual);
}

test "grains on square 32" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 2_147_483_648;
    const actual = try grains.square(32);
    try testing.expectEqual(expected, actual);
}

test "grains on square 64" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 9_223_372_036_854_775_808;
    const actual = try grains.square(64);
    try testing.expectEqual(expected, actual);
}

test "square 0 produces an error" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = ChessboardError.IndexOutOfBounds;
    const actual = grains.square(0);
    try testing.expectError(expected, actual);
}

test "square greater than 64 produces an error" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = ChessboardError.IndexOutOfBounds;
    const actual = grains.square(65);
    try testing.expectError(expected, actual);
}

test "returns the total number of grains on the board" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: u64 = 18_446_744_073_709_551_615;
    const actual = grains.total();
    try testing.expectEqual(expected, actual);
}
