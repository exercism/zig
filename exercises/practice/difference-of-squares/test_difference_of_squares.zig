const std = @import("std");
const testing = std.testing;

const difference_of_squares = @import("difference_of_squares.zig");

test "square of sum up to 1" {
    const expected = 1;
    const actual = comptime difference_of_squares.squareOfSum(1);
    try testing.expectEqual(expected, actual);
}

test "square of sum up to 5" {
    const expected = 225;
    const actual = comptime difference_of_squares.squareOfSum(5);
    try testing.expectEqual(expected, actual);
}

test "square of sum up to 100" {
    const expected = 25_502_500;
    const actual = comptime difference_of_squares.squareOfSum(100);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 1" {
    const expected = 1;
    const actual = comptime difference_of_squares.sumOfSquares(1);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 5" {
    const expected = 55;
    const actual = comptime difference_of_squares.sumOfSquares(5);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 100" {
    const expected = 338_350;
    const actual = comptime difference_of_squares.sumOfSquares(100);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 1" {
    const expected = 0;
    const actual = comptime difference_of_squares.differenceOfSquares(1);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 5" {
    const expected = 170;
    const actual = comptime difference_of_squares.differenceOfSquares(5);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 100" {
    const expected = 25_164_150;
    const actual = comptime difference_of_squares.differenceOfSquares(100);
    try testing.expectEqual(expected, actual);
}
