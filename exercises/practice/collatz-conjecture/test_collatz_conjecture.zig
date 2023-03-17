const std = @import("std");
const testing = std.testing;

const collatz_conjecture = @import("collatz_conjecture.zig");
const ComputationError = collatz_conjecture.ComputationError;

test "zero steps for one" {
    const expected: usize = 0;
    const actual = try collatz_conjecture.steps(1);
    try testing.expectEqual(expected, actual);
}

test "divide if even" {
    const expected: usize = 4;
    const actual = try collatz_conjecture.steps(16);
    try testing.expectEqual(expected, actual);
}

test "even and odd steps" {
    const expected: usize = 9;
    const actual = try collatz_conjecture.steps(12);
    try testing.expectEqual(expected, actual);
}

test "large number of even and odd steps" {
    const expected: usize = 152;
    const actual = try collatz_conjecture.steps(1_000_000);
    try testing.expectEqual(expected, actual);
}

test "zero is an error" {
    const expected = ComputationError.IllegalArgument;
    const actual = collatz_conjecture.steps(0);
    try testing.expectError(expected, actual);
}
