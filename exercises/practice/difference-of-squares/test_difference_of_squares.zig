const std = @import("std");
const testing = std.testing;

const difference_of_squares = @import("difference_of_squares.zig");

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "square of sum up to 1" {
    const expected: usize = 1;
    const actual = difference_of_squares.squareOfSum(1);
    try testing.expectEqual(expected, actual);
}

test "square of sum up to 5" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 225;
    const actual = difference_of_squares.squareOfSum(5);
    try testing.expectEqual(expected, actual);
}

test "square of sum up to 100" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 25_502_500;
    const actual = difference_of_squares.squareOfSum(100);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 1" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 1;
    const actual = difference_of_squares.sumOfSquares(1);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 5" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 55;
    const actual = difference_of_squares.sumOfSquares(5);
    try testing.expectEqual(expected, actual);
}

test "sum of squares up to 100" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 338_350;
    const actual = difference_of_squares.sumOfSquares(100);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 1" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 0;
    const actual = difference_of_squares.differenceOfSquares(1);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 5" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 170;
    const actual = difference_of_squares.differenceOfSquares(5);
    try testing.expectEqual(expected, actual);
}

test "difference of squares up to 100" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 25_164_150;
    const actual = difference_of_squares.differenceOfSquares(100);
    try testing.expectEqual(expected, actual);
}
