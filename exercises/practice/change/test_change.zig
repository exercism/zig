const std = @import("std");
const testing = std.testing;

const change = @import("change.zig");

test "change for 1 cent" {
    const expected = [_]u64{1};
    const coins = [_]u64{ 1, 5, 10, 25 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "single coin change" {
    const expected = [_]u64{25};
    const coins = [_]u64{ 1, 5, 10, 25, 100 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 25);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "multiple coin change" {
    const expected = [_]u64{ 5, 10 };
    const coins = [_]u64{ 1, 5, 10, 25, 100 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 15);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "change with Lilliputian Coins" {
    const expected = [_]u64{ 4, 4, 15 };
    const coins = [_]u64{ 1, 4, 15, 20, 50 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 23);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "change with Lower Elbonia Coins" {
    const expected = [_]u64{ 21, 21, 21 };
    const coins = [_]u64{ 1, 5, 10, 21, 25 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 63);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "large target values" {
    const expected = [_]u64{ 2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100 };
    const coins = [_]u64{ 1, 2, 5, 10, 20, 50, 100 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 999);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "possible change without unit coins available" {
    const expected = [_]u64{ 2, 2, 2, 5, 10 };
    const coins = [_]u64{ 2, 5, 10, 20, 50 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 21);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "another possible change without unit coins available" {
    const expected = [_]u64{ 4, 4, 4, 5, 5, 5 };
    const coins = [_]u64{ 4, 5 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 27);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "a greedy approach is not optimal" {
    const expected = [_]u64{ 10, 10 };
    const coins = [_]u64{ 1, 10, 11 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 20);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "no coins make 0 change" {
    const expected = [_]u64{};
    const coins = [_]u64{ 1, 5, 10, 21, 25 };
    const actual = try change.findFewestCoins(testing.allocator, &coins, 0);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u64, &expected, actual);
}

test "error testing for change smaller than the smallest of coins" {
    const coins = [_]u64{ 5, 10 };
    const actual = change.findFewestCoins(testing.allocator, &coins, 3);
    try testing.expectError(change.ChangeError.UnreachableTarget, actual);
}

test "error if no combination can add up to target" {
    const coins = [_]u64{ 5, 10 };
    const actual = change.findFewestCoins(testing.allocator, &coins, 94);
    try testing.expectError(change.ChangeError.UnreachableTarget, actual);
}

test "cannot find negative change values" {
    const coins = [_]u64{ 1, 2, 5 };
    const actual = change.findFewestCoins(testing.allocator, &coins, -5);
    try testing.expectError(change.ChangeError.NegativeTarget, actual);
}
