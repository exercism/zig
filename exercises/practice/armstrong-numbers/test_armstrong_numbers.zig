const std = @import("std");
const testing = std.testing;

const armstrong_numbers = @import("armstrong_numbers.zig");

test "zero is an armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(0));
}

test "single-digit numbers are armstrong numbers" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(5));
}

test "there are no two-digit armstrong numbers" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(10));
}

test "three-digit number that is an armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(153));
}

test "three-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(100));
}

test "four-digit number that is an armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(9_474));
}

test "four-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(9_475));
}

test "seven-digit number that is an armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(9_926_315));
}

test "seven-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(9_926_314));
}

test "nineteen-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(9_999_999_999_999_999_999));
}

test "twenty-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(18_446_744_073_709_551_615));
}
