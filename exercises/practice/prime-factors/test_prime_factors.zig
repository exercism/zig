const std = @import("std");
const testing = std.testing;

const prime_factors = @import("prime_factors.zig");

test "no factors" {
    const expected = [_]u64{};
    const actual = try prime_factors.factors(testing.allocator, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "prime number" {
    const expected = [_]u64{2};
    const actual = try prime_factors.factors(testing.allocator, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "another prime number" {
    const expected = [_]u64{3};
    const actual = try prime_factors.factors(testing.allocator, 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "square of a prime" {
    const expected = [_]u64{ 3, 3 };
    const actual = try prime_factors.factors(testing.allocator, 9);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of first prime" {
    const expected = [_]u64{ 2, 2 };
    const actual = try prime_factors.factors(testing.allocator, 4);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "cube of a prime" {
    const expected = [_]u64{ 2, 2, 2 };
    const actual = try prime_factors.factors(testing.allocator, 8);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of second prime" {
    const expected = [_]u64{ 3, 3, 3 };
    const actual = try prime_factors.factors(testing.allocator, 27);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of third prime" {
    const expected = [_]u64{ 5, 5, 5, 5 };
    const actual = try prime_factors.factors(testing.allocator, 625);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of first and second prime" {
    const expected = [_]u64{ 2, 3 };
    const actual = try prime_factors.factors(testing.allocator, 6);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of primes and non-primes" {
    const expected = [_]u64{ 2, 2, 3 };
    const actual = try prime_factors.factors(testing.allocator, 12);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of primes" {
    const expected = [_]u64{ 5, 17, 23, 461 };
    const actual = try prime_factors.factors(testing.allocator, 901255);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "factors include a large prime" {
    const expected = [_]u64{ 11, 9539, 894119 };
    const actual = try prime_factors.factors(testing.allocator, 93819012551);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "product of three large primes" {
    const expected = [_]u64{ 2077681, 2099191, 2101243 };
    const actual = try prime_factors.factors(testing.allocator, 9164464719174396253);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "one very large prime" {
    const expected = [_]u64{4016465016163};
    const actual = try prime_factors.factors(testing.allocator, 4016465016163);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}
