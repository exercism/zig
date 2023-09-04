const std = @import("std");
const testing = std.testing;

const sum = @import("sum_of_multiples.zig").sum;

test "no multiples within limit" {
    const expected: u64 = 0;
    const factors = [_]u32{ 3, 5 };
    const limit = 1;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "one factor has multiples within limit" {
    const expected: u64 = 3;
    const factors = [_]u32{ 3, 5 };
    const limit = 4;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "more than one multiple within limit" {
    const expected: u64 = 9;
    const factors = [_]u32{3};
    const limit = 7;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "more than one factor with multiples within limit" {
    const expected: u64 = 23;
    const factors = [_]u32{ 3, 5 };
    const limit = 10;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "each multiple is only counted once" {
    const expected: u64 = 2318;
    const factors = [_]u32{ 3, 5 };
    const limit = 100;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "a much larger limit" {
    const expected: u64 = 233_168;
    const factors = [_]u32{ 3, 5 };
    const limit = 1000;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "three factors" {
    const expected: u64 = 51;
    const factors = [_]u32{ 7, 13, 17 };
    const limit = 20;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "factors not relatively prime" {
    const expected: u64 = 30;
    const factors = [_]u32{ 4, 6 };
    const limit = 15;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "some pairs of factors relatively prime and some not" {
    const expected: u64 = 4419;
    const factors = [_]u32{ 5, 6, 8 };
    const limit = 150;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "one factor is a multiple of another" {
    const expected: u64 = 275;
    const factors = [_]u32{ 5, 25 };
    const limit = 51;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "much larger factors" {
    const expected: u64 = 2_203_160;
    const factors = [_]u32{ 43, 47 };
    const limit = 10_000;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "all numbers are multiples of 1" {
    const expected: u64 = 4_950;
    const factors = [_]u32{1};
    const limit = 100;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "no factors means an empty sum" {
    const expected: u64 = 0;
    const factors = [_]u32{};
    const limit = 10_000;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "the only multiple of 0 is 0" {
    const expected: u64 = 0;
    const factors = [_]u32{0};
    const limit = 1;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "the factor 0 does not affect the sum of multiples of other factors" {
    const expected: u64 = 3;
    const factors = [_]u32{ 3, 0 };
    const limit = 4;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "solutions using include-exclude must extend to cardinality greater than 3" {
    const expected: u64 = 39_614_537;
    const factors = [_]u32{ 2, 3, 5, 7, 11 };
    const limit = 10_000;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}

test "sum is greater than maximum value of u32" {
    // Note that for a u32 `limit`, the maximum sum of multiples fits in a u64.
    const expected: u64 = 4_500_000_000;
    const factors = [_]u32{100_000_000};
    const limit = 1_000_000_000;
    const actual = try sum(testing.allocator, &factors, limit);
    try testing.expectEqual(expected, actual);
}
