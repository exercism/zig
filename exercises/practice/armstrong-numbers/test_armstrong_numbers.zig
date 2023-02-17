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

test "33-digit number that is an armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(186_709_961_001_538_790_100_634_132_976_990));
}

test "38-digit number that is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(99_999_999_999_999_999_999_999_999_999_999_999_999));
}

test "the largest and last armstrong number" {
    try testing.expect(armstrong_numbers.isArmstrongNumber(115_132_219_018_763_992_565_095_597_973_971_522_401));
}

test "the largest 128-bit unsigned integer is not an armstrong number" {
    try testing.expect(!armstrong_numbers.isArmstrongNumber(340_282_366_920_938_463_463_374_607_431_768_211_455));
}
