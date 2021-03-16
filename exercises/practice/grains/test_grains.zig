const std = @import("std");
const testing = std.testing;

const grains = @import("grains.zig");
const ChessboardError = grains.ChessboardError;

test "grains on square 1" {
    const expected = 1;
    const actual = comptime try grains.square(1);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 2" {
    const expected = 2;
    const actual = comptime try grains.square(2);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 3" {
    const expected = 4;
    const actual = comptime try grains.square(3);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 4" {
    const expected = 8;
    const actual = comptime try grains.square(4);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 16" {
    const expected = 32768;
    const actual = comptime try grains.square(16);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 32" {
    const expected = 2147483648;
    const actual = comptime try grains.square(32);
    comptime testing.expectEqual(expected, actual);
}

test "grains on square 64" {
    const expected = 9223372036854775808;
    const actual = comptime try grains.square(64);
    comptime testing.expectEqual(expected, actual);
}

test "square 0 raises an exception" {
    const expected = ChessboardError.IndexOutOfBounds;
    const actual = comptime grains.square(0);
    testing.expectError(expected, actual);
}

test "negative square raises an expection" {
    const expected = ChessboardError.IndexOutOfBounds;
    const actual = comptime grains.square(-1);
    testing.expectError(expected, actual);
}

test "square greater than 64 raises an exception" {
    const expected = ChessboardError.IndexOutOfBounds;
    const actual = comptime grains.square(65);
    testing.expectError(expected, actual);
}

test "returns the total number of grains on the board" {
    const expected = 18446744073709551615;
    const actual = comptime grains.total();
    comptime testing.expectEqual(expected, actual);
}
