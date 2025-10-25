const std = @import("std");
const testing = std.testing;

const zebra_puzzle = @import("zebra_puzzle.zig");
const solve = zebra_puzzle.solve;
const Nationality = zebra_puzzle.Nationality;

test "resident who drinks water" {
    const expected: Nationality = .norwegian;
    const actual = (try solve(testing.allocator)).drinks_water;
    try testing.expectEqual(expected, actual);
}

test "resident who owns zebra" {
    const expected: Nationality = .japanese;
    const actual = (try solve(testing.allocator)).owns_zebra;
    try testing.expectEqual(expected, actual);
}
