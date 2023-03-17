const std = @import("std");
const testing = std.testing;

const numbers = @import("rational_numbers.zig");

test "add two positive rational numbers" {
    const expected = try numbers.Rational.init(7, 6);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).add(numbers.Rational.init(2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "add a positive rational number and a negative rational number" {
    const expected = try numbers.Rational.init(-1, 6);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).add(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "add two negative rational numbers" {
    const expected = try numbers.Rational.init(-7, 6);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).add(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "add a rational number to its additive inverse" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).add(numbers.Rational.init(-1, 2) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "subtract two positive rational numbers" {
    const expected = try numbers.Rational.init(-1, 6);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).sub(numbers.Rational.init(2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "subtract a positive rational number and a negative rational number" {
    const expected = try numbers.Rational.init(7, 6);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).sub(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "subtract two negative rational numbers" {
    const expected = try numbers.Rational.init(1, 6);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).sub(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "subtract a rational number from itself" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).sub(numbers.Rational.init(1, 2) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply two positive rational numbers" {
    const expected = try numbers.Rational.init(1, 3);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).mul(numbers.Rational.init(2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply a negative rational number by a positive rational number" {
    const expected = try numbers.Rational.init(-1, 3);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).mul(numbers.Rational.init(2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply two negative rational numbers" {
    const expected = try numbers.Rational.init(1, 3);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).mul(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply a rational number by its reciprocal" {
    const expected = try numbers.Rational.init(1, 1);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).mul(numbers.Rational.init(2, 1) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply a rational number by 1" {
    const expected = try numbers.Rational.init(1, 2);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).mul(numbers.Rational.init(1, 1) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "multiply a rational number by 0" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).mul(numbers.Rational.init(0, 1) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "divide two positive rational numbers" {
    const expected = try numbers.Rational.init(3, 4);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).div(numbers.Rational.init(2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "divide a positive rational number by a negative rational number" {
    const expected = try numbers.Rational.init(-3, 4);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).div(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "divide two negative rational numbers" {
    const expected = try numbers.Rational.init(3, 4);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).div(numbers.Rational.init(-2, 3) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "divide a rational number by 1" {
    const expected = try numbers.Rational.init(1, 2);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).div(numbers.Rational.init(1, 1) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "absolute value of a positive rational number" {
    const expected = try numbers.Rational.init(1, 2);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).abs();
    try testing.expectEqual(expected, actual);
}

test "absolute value of a negative rational number" {
    const expected = try numbers.Rational.init(1, 2);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).abs();
    try testing.expectEqual(expected, actual);
}

test "absolute value of zero" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(0, 1) catch unreachable).abs();
    try testing.expectEqual(expected, actual);
}

test "raise a positive rational number to a positive integer power" {
    const expected = try numbers.Rational.init(1, 8);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).exp(3);
    try testing.expectEqual(expected, actual);
}

test "raise a negative rational number to a positive integer power" {
    const expected = try numbers.Rational.init(-1, 8);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).exp(3);
    try testing.expectEqual(expected, actual);
}

test "raise zero to an integer power" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(0, 1) catch unreachable).exp(5);
    try testing.expectEqual(expected, actual);
}

test "raise one to an integer power" {
    const expected = try numbers.Rational.init(1, 1);
    const actual = (numbers.Rational.init(1, 1) catch unreachable).exp(4);
    try testing.expectEqual(expected, actual);
}

test "raise a positive rational number to the power of zero" {
    const expected = try numbers.Rational.init(1, 1);
    const actual = (numbers.Rational.init(1, 2) catch unreachable).exp(0);
    try testing.expectEqual(expected, actual);
}

test "raise a negative rational number to the power of zero" {
    const expected = try numbers.Rational.init(1, 1);
    const actual = (numbers.Rational.init(-1, 2) catch unreachable).exp(0);
    try testing.expectEqual(expected, actual);
}

test "raise a real number to a positive rational number" {
    const expected = 16.0;
    const actual = comptime (numbers.Rational.init(4, 3) catch unreachable).exp_real(8);
    try testing.expectEqual(expected, actual);
}

test "raise a real number to a negative rational number" {
    const tolerance = 0.001;
    const expected = 0.333;
    const actual = comptime (numbers.Rational.init(-1, 2) catch unreachable).exp_real(9);
    try testing.expect(std.math.approxEqAbs(f64, expected, actual, tolerance));
}

test "raise a real number to a zero rational number" {
    const expected = 1.0;
    const actual = comptime (numbers.Rational.init(0, 1) catch unreachable).exp_real(2);
    try testing.expectEqual(expected, actual);
}

test "reduce a positive rational number to lowest terms" {
    const expected = try numbers.Rational.init(1, 2);
    const actual = (numbers.Rational.init(2, 4) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "reduce a negative rational number to lowest terms" {
    const expected = try numbers.Rational.init(-2, 3);
    const actual = (numbers.Rational.init(-4, 6) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "reduce a rational number with a negative denominator to lowest terms" {
    const expected = try numbers.Rational.init(-1, 3);
    const actual = (numbers.Rational.init(3, -9) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "reduce zero to lowest terms" {
    const expected = try numbers.Rational.init(0, 1);
    const actual = (numbers.Rational.init(0, 6) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "reduce an integer to lowest terms" {
    const expected = try numbers.Rational.init(-2, 1);
    const actual = (numbers.Rational.init(-14, 7) catch unreachable);
    try testing.expectEqual(expected, actual);
}

test "reduce one to lowest terms" {
    const expected = try numbers.Rational.init(1, 1);
    const actual = (numbers.Rational.init(13, 13) catch unreachable);
    try testing.expectEqual(expected, actual);
}
