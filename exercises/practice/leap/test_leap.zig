const std = @import("std");
const testing = std.testing;

const leap = @import("leap.zig");

test "year not divisible by 4 in common year" {
    comptime testing.expect(!leap.leap(2015));
}

test "year divisible by 2, not divisible by 4 in common year" {
    comptime testing.expect(!leap.leap(1970));
}

test "year divisible by 4, not divisible by 100 in leap year" {
    comptime testing.expect(leap.leap(1996));
}

test "year divisible by 4 and 5 is still a leap year" {
    comptime testing.expect(leap.leap(1960));
}

test "year divisible by 100, not divisible by 400 in common year" {
    comptime testing.expect(!leap.leap(2100));
}

test "year divisible by 100 but not by 3 is still not a leap year" {
    comptime testing.expect(!leap.leap(1900));
}

test "year divisible by 400 is leap year" {
    comptime testing.expect(leap.leap(2000));
}

test "year divisible by 400 but not by 125 is still a leap year" {
    comptime testing.expect(leap.leap(2400));
}

test "year divisible by 200, not divisible by 400 in common year" {
    comptime testing.expect(!leap.leap(1800));
}
