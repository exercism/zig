const std = @import("std");
const testing = std.testing;

const grains = @import("grains.zig");
const ChessboardError = grains.ChessboardError;

test "grains on square 1" {
    const expected: u64 = 1;
    const actual = try grains.square(1);
    try testing.expectEqual(expected, actual);
}

test "grains on square 2" {
    const expected: u64 = 2;
    const actual = try grains.square(2);
    try testing.expectEqual(expected, actual);
}

test "grains on square 3" {
    const expected: u64 = 4;
    const actual = try grains.square(3);
    try testing.expectEqual(expected, actual);
}

test "grains on square 4" {
    const expected: u64 = 8;
    const actual = try grains.square(4);
    try testing.expectEqual(expected, actual);
}

test "grains on square 16" {
    const expected: u64 = 32_768;
    const actual = try grains.square(16);
    try testing.expectEqual(expected, actual);
}

test "grains on square 32" {
    const expected: u64 = 2_147_483_648;
    const actual = try grains.square(32);
    try testing.expectEqual(expected, actual);
}

test "grains on square 64" {
    const expected: u64 = 9_223_372_036_854_775_808;
    const actual = try grains.square(64);
    try testing.expectEqual(expected, actual);
}

test "square 0 produces an error" {
    const expected = ChessboardError.IndexOutOfBounds;
    const actual = grains.square(0);
    try testing.expectError(expected, actual);
}

test "square greater than 64 produces an error" {
    const expected = ChessboardError.IndexOutOfBounds;
    const actual = grains.square(65);
    try testing.expectError(expected, actual);
}

test "returns the total number of grains on the board" {
    const expected: u64 = 18_446_744_073_709_551_615;
    const actual = grains.total();
    try testing.expectEqual(expected, actual);
}
