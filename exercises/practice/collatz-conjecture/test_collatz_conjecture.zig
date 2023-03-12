const std = @import("std");
const testing = std.testing;

const collatz_conjecture = @import("collatz_conjecture.zig");
const ComputationError = collatz_conjecture.ComputationError;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "zero steps for one" {
    const expected: usize = 0;
    const actual = try collatz_conjecture.steps(1);
    try testing.expectEqual(expected, actual);
}

test "divide if even" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 4;
    const actual = try collatz_conjecture.steps(16);
    try testing.expectEqual(expected, actual);
}

test "even and odd steps" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 9;
    const actual = try collatz_conjecture.steps(12);
    try testing.expectEqual(expected, actual);
}

test "large number of even and odd steps" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected: usize = 152;
    const actual = try collatz_conjecture.steps(1_000_000);
    try testing.expectEqual(expected, actual);
}

test "zero is an error" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = ComputationError.IllegalArgument;
    const actual = collatz_conjecture.steps(0);
    try testing.expectError(expected, actual);
}
