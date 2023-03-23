const std = @import("std");
const testing = std.testing;

const sum = @import("sum_of_multiples.zig").sum;

test "no multiples within limit" {
    const expected: usize = 0;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 5 }, 1);
    try testing.expectEqual(expected, actual);
}

test "one factor has multiples within limit" {
    const expected: usize = 3;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 5 }, 4);
    try testing.expectEqual(expected, actual);
}

test "more than one multiple within limit" {
    const expected: usize = 9;
    const actual = try sum(testing.allocator, &[_]usize{3}, 7);
    try testing.expectEqual(expected, actual);
}

test "more than one factor with multiples within limit" {
    const expected: usize = 23;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 5 }, 10);
    try testing.expectEqual(expected, actual);
}

test "each multiple is only counted once" {
    const expected: usize = 2318;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 5 }, 100);
    try testing.expectEqual(expected, actual);
}

test "a much larger limit" {
    const expected: usize = 233_168;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 5 }, 1000);
    try testing.expectEqual(expected, actual);
}

test "three factors" {
    const expected: usize = 51;
    const actual = try sum(testing.allocator, &[_]usize{ 7, 13, 17 }, 20);
    try testing.expectEqual(expected, actual);
}

test "factors not relatively prime" {
    const expected: usize = 30;
    const actual = try sum(testing.allocator, &[_]usize{ 4, 6 }, 15);
    try testing.expectEqual(expected, actual);
}

test "some pairs of factors relatively prime and some not" {
    const expected: usize = 4419;
    const actual = try sum(testing.allocator, &[_]usize{ 5, 6, 8 }, 150);
    try testing.expectEqual(expected, actual);
}

test "one factor is a multiple of another" {
    const expected: usize = 275;
    const actual = try sum(testing.allocator, &[_]usize{ 5, 25 }, 51);
    try testing.expectEqual(expected, actual);
}

test "much larger factors" {
    const expected: usize = 2_203_160;
    const actual = try sum(testing.allocator, &[_]usize{ 43, 47 }, 10_000);
    try testing.expectEqual(expected, actual);
}

test "all numbers are multiples of 1" {
    const expected: usize = 4_950;
    const actual = try sum(testing.allocator, &[_]usize{1}, 100);
    try testing.expectEqual(expected, actual);
}

test "no factors means an empty sum" {
    const expected: usize = 0;
    const actual = try sum(testing.allocator, &[_]usize{}, 10_000);
    try testing.expectEqual(expected, actual);
}

test "the only multiple of 0 is 0" {
    const expected: usize = 0;
    const actual = try sum(testing.allocator, &[_]usize{0}, 1);
    try testing.expectEqual(expected, actual);
}

test "the factor 0 does not affect the sum of multiples of other factors" {
    const expected: usize = 3;
    const actual = try sum(testing.allocator, &[_]usize{ 3, 0 }, 4);
    try testing.expectEqual(expected, actual);
}

test "solutions using include-exclude must extend to cardinality greater than 3" {
    const expected: usize = 39_614_537;
    const actual = try sum(testing.allocator, &[_]usize{ 2, 3, 5, 7, 11 }, 10_000);
    try testing.expectEqual(expected, actual);
}
