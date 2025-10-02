const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const say = @import("say.zig");
const SayError = say.SayError;

fn sayTest(allocator: mem.Allocator, number: i41, expected: []const u8) anyerror!void {
    const actual = try say.say(allocator, number);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "zero" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 0, "zero" },
    );
}

test "one" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1, "one" },
    );
}

test "fourteen" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 14, "fourteen" },
    );
}

test "twenty" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 20, "twenty" },
    );
}

test "twenty-two" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 22, "twenty-two" },
    );
}

test "thirty" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 30, "thirty" },
    );
}

test "ninety-nine" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 99, "ninety-nine" },
    );
}

test "one hundred" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 100, "one hundred" },
    );
}

test "one hundred twenty-three" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 123, "one hundred twenty-three" },
    );
}

test "two hundred" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 200, "two hundred" },
    );
}

test "nine hundred ninety-nine" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 999, "nine hundred ninety-nine" },
    );
}

test "one thousand" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1_000, "one thousand" },
    );
}

test "one thousand two hundred thirty-four" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1_234, "one thousand two hundred thirty-four" },
    );
}

test "one million" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1_000_000, "one million" },
    );
}

test "one million two thousand three hundred forty-five" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1_002_345, "one million two thousand three hundred forty-five" },
    );
}

test "one billion" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 1_000_000_000, "one billion" },
    );
}

test "a big number" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 987_654_321_123, "nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three" },
    );
}

test "numbers below zero are out of range" {
    try testing.expectError(SayError.OutOfRange, say.say(testing.allocator, -1));
}

test "numbers above 999,999,999,999 are out of range" {
    try testing.expectError(SayError.OutOfRange, say.say(testing.allocator, 1_000_000_000_000));
}

test "additional big number" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 19_011_016_013, "nineteen billion eleven million sixteen thousand thirteen" },
    );
}

test "different big number" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 812_000_070_017, "eight hundred twelve billion seventy thousand seventeen" },
    );
}

test "alternative big number" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 60_010_015_018, "sixty billion ten million fifteen thousand eighteen" },
    );
}

test "twelve sevens" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        sayTest,
        .{ 777_777_777_777, "seven hundred seventy-seven billion seven hundred seventy-seven million seven hundred seventy-seven thousand seven hundred seventy-seven" },
    );
}
