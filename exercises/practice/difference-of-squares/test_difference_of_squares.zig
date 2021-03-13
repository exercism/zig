const std = @import("std");
const testing = std.testing;

const difference_of_squares = @import("difference_of_squares.zig");

test "square of sum up to 1" {
    const expected = 1;
    const actual = comptime difference_of_squares.square_of_sum(1);
    comptime testing.expectEqual(expected, actual);
}

test "square of sum up to 5" {
    const expected = 225;
    const actual = comptime difference_of_squares.square_of_sum(5);
    comptime testing.expectEqual(expected, actual);
}

test "square of sum up to 100" {
    const expected = 25502500;
    const actual = comptime difference_of_squares.square_of_sum(100);
    comptime testing.expectEqual(expected, actual);
}

test "sum of squares up to 1" {
    const expected = 1;
    const actual = comptime difference_of_squares.sum_of_squares(1);
    comptime testing.expectEqual(expected, actual);
}

test "sum of squares up to 5" {
    const expected = 55;
    const actual = comptime difference_of_squares.sum_of_squares(5);
    comptime testing.expectEqual(expected, actual);
}

test "sum of squares up to 100" {
    const expected = 338350;
    const actual = comptime difference_of_squares.sum_of_squares(100);
    comptime testing.expectEqual(expected, actual);
}

test "difference of squares up to 1" {
    const expected = 0;
    const actual = comptime difference_of_squares.difference_of_squares(1);
    comptime testing.expectEqual(expected, actual);
}

test "difference of squares up to 5" {
    const expected = 170;
    const actual = comptime difference_of_squares.difference_of_squares(5);
    comptime testing.expectEqual(expected, actual);
}

test "difference of squares up to 100" {
    const expected = 25164150;
    const actual = comptime difference_of_squares.difference_of_squares(100);
    comptime testing.expectEqual(expected, actual);
}
