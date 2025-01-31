const std = @import("std");
const testing = std.testing;

const nth_prime = @import("nth_prime.zig");

test "first prime" {
    const p = try nth_prime.prime(testing.allocator, 1);
    try testing.expectEqual(2, p);
}

test "second prime" {
    const p = try nth_prime.prime(testing.allocator, 2);
    try testing.expectEqual(3, p);
}

test "third prime" {
    const p = try nth_prime.prime(testing.allocator, 3);
    try testing.expectEqual(5, p);
}

test "fourth prime" {
    const p = try nth_prime.prime(testing.allocator, 4);
    try testing.expectEqual(7, p);
}

test "fifth prime" {
    const p = try nth_prime.prime(testing.allocator, 5);
    try testing.expectEqual(11, p);
}

test "sixth prime" {
    const p = try nth_prime.prime(testing.allocator, 6);
    try testing.expectEqual(13, p);
}

test "seventh prime" {
    const p = try nth_prime.prime(testing.allocator, 7);
    try testing.expectEqual(17, p);
}

test "big prime" {
    const p = try nth_prime.prime(testing.allocator, 10001);
    try testing.expectEqual(104743, p);
}
