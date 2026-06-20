const std = @import("std");
const testing = std.testing;

const isArmstrongNumber = @import("armstrong_numbers.zig").isArmstrongNumber;

fn testIsArmstrongNumber(number: u128, expected: bool) !void {
    try testing.expectEqual(expected, isArmstrongNumber(number));
}

test "Zero is an Armstrong number" {
    try testIsArmstrongNumber(0, true);
}

test "Single-digit numbers are Armstrong numbers" {
    try testIsArmstrongNumber(5, true);
}

test "There are no two-digit Armstrong numbers" {
    try testIsArmstrongNumber(10, false);
}

test "Three-digit number that is an Armstrong number" {
    try testIsArmstrongNumber(153, true);
}

test "Three-digit number that is not an Armstrong number" {
    try testIsArmstrongNumber(100, false);
}

test "Four-digit number that is an Armstrong number" {
    try testIsArmstrongNumber(9_474, true);
}

test "Four-digit number that is not an Armstrong number" {
    try testIsArmstrongNumber(9_475, false);
}

test "Seven-digit number that is an Armstrong number" {
    try testIsArmstrongNumber(9_926_315, true);
}

test "Seven-digit number that is not an Armstrong number" {
    try testIsArmstrongNumber(9_926_314, false);
}

test "Armstrong number containing seven zeroes" {
    try testIsArmstrongNumber(186_709_961_001_538_790_100_634_132_976_990, true);
}

test "The largest and last Armstrong number" {
    try testIsArmstrongNumber(115_132_219_018_763_992_565_095_597_973_971_522_401, true);
}

test "38-digit number that is not an armstrong number" {
    try testIsArmstrongNumber(99_999_999_999_999_999_999_999_999_999_999_999_999, false);
}

test "the largest 128-bit unsigned integer value is not an armstrong number" {
    try testIsArmstrongNumber(340_282_366_920_938_463_463_374_607_431_768_211_455, false);
}
