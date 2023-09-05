const std = @import("std");
const testing = std.testing;

const score = @import("yacht.zig").score;

test "yacht" {
    const expected: u32 = 50;
    const actual = score([_]u3{ 5, 5, 5, 5, 5 }, .yacht);
    try testing.expectEqual(expected, actual);
}

test "not yacht" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 3, 3, 2, 5 }, .yacht);
    try testing.expectEqual(expected, actual);
}

test "ones" {
    const expected: u32 = 3;
    const actual = score([_]u3{ 1, 1, 1, 3, 5 }, .ones);
    try testing.expectEqual(expected, actual);
}

test "ones, out of order" {
    const expected: u32 = 3;
    const actual = score([_]u3{ 3, 1, 1, 5, 1 }, .ones);
    try testing.expectEqual(expected, actual);
}

test "no ones" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 4, 3, 6, 5, 5 }, .ones);
    try testing.expectEqual(expected, actual);
}

test "twos" {
    const expected: u32 = 2;
    const actual = score([_]u3{ 2, 3, 4, 5, 6 }, .twos);
    try testing.expectEqual(expected, actual);
}

test "fours" {
    const expected: u32 = 8;
    const actual = score([_]u3{ 1, 4, 1, 4, 1 }, .fours);
    try testing.expectEqual(expected, actual);
}

test "yacht counted as threes" {
    const expected: u32 = 15;
    const actual = score([_]u3{ 3, 3, 3, 3, 3 }, .threes);
    try testing.expectEqual(expected, actual);
}

test "yacht of 3s counted as fives" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 3, 3, 3, 3, 3 }, .fives);
    try testing.expectEqual(expected, actual);
}

test "fives" {
    const expected: u32 = 10;
    const actual = score([_]u3{ 1, 5, 3, 5, 3 }, .fives);
    try testing.expectEqual(expected, actual);
}

test "sixes" {
    const expected: u32 = 6;
    const actual = score([_]u3{ 2, 3, 4, 5, 6 }, .sixes);
    try testing.expectEqual(expected, actual);
}

test "full house two small, three big" {
    const expected: u32 = 16;
    const actual = score([_]u3{ 2, 2, 4, 4, 4 }, .full_house);
    try testing.expectEqual(expected, actual);
}

test "full house three small, two big" {
    const expected: u32 = 19;
    const actual = score([_]u3{ 5, 3, 3, 5, 3 }, .full_house);
    try testing.expectEqual(expected, actual);
}

test "two pair is not a full house" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 2, 2, 4, 4, 5 }, .full_house);
    try testing.expectEqual(expected, actual);
}

test "four of a kind is not a full house" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 4, 4, 4, 4 }, .full_house);
    try testing.expectEqual(expected, actual);
}

test "yacht is not a full house" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 2, 2, 2, 2, 2 }, .full_house);
    try testing.expectEqual(expected, actual);
}

test "four of a kind" {
    const expected: u32 = 24;
    const actual = score([_]u3{ 6, 6, 4, 6, 6 }, .four_of_a_kind);
    try testing.expectEqual(expected, actual);
}

test "yacht can be scored as four of a kind" {
    const expected: u32 = 12;
    const actual = score([_]u3{ 3, 3, 3, 3, 3 }, .four_of_a_kind);
    try testing.expectEqual(expected, actual);
}

test "full house is not four of a kind" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 3, 3, 3, 5, 5 }, .four_of_a_kind);
    try testing.expectEqual(expected, actual);
}

test "little straight" {
    const expected: u32 = 30;
    const actual = score([_]u3{ 3, 5, 4, 1, 2 }, .little_straight);
    try testing.expectEqual(expected, actual);
}

test "little straight as big straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 2, 3, 4, 5 }, .big_straight);
    try testing.expectEqual(expected, actual);
}

test "four in order but not a little straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 1, 2, 3, 4 }, .little_straight);
    try testing.expectEqual(expected, actual);
}

test "no pairs but not a little straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 2, 3, 4, 6 }, .little_straight);
    try testing.expectEqual(expected, actual);
}

test "minimum is 1, maximum is 5, but not a little straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 1, 1, 3, 4, 5 }, .little_straight);
    try testing.expectEqual(expected, actual);
}

test "big straight" {
    const expected: u32 = 30;
    const actual = score([_]u3{ 4, 6, 2, 5, 3 }, .big_straight);
    try testing.expectEqual(expected, actual);
}

test "big straight as little straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 6, 5, 4, 3, 2 }, .little_straight);
    try testing.expectEqual(expected, actual);
}

test "no pairs but not a big straight" {
    const expected: u32 = 0;
    const actual = score([_]u3{ 6, 5, 4, 3, 1 }, .big_straight);
    try testing.expectEqual(expected, actual);
}

test "choice" {
    const expected: u32 = 23;
    const actual = score([_]u3{ 3, 3, 5, 6, 6 }, .choice);
    try testing.expectEqual(expected, actual);
}

test "yacht as choice" {
    const expected: u32 = 10;
    const actual = score([_]u3{ 2, 2, 2, 2, 2 }, .choice);
    try testing.expectEqual(expected, actual);
}
