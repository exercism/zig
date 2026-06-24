const std = @import("std");
const testing = std.testing;

const score = @import("yacht.zig").score;
const Category = @import("yacht.zig").Category;

fn testScore(dice: [5]u3, category: Category, expected: u32) !void {
    try testing.expectEqual(expected, score(dice, category));
}

test "no ones" {
    try testScore([_]u3{ 4, 3, 6, 5, 5 }, .ones, 0);
}

test "ones" {
    try testScore([_]u3{ 1, 1, 1, 3, 5 }, .ones, 3);
}

test "ones, out of order" {
    try testScore([_]u3{ 3, 1, 1, 5, 1 }, .ones, 3);
}

test "twos" {
    try testScore([_]u3{ 2, 3, 4, 5, 6 }, .twos, 2);
}

test "yacht counted as threes" {
    try testScore([_]u3{ 3, 3, 3, 3, 3 }, .threes, 15);
}

test "fours" {
    try testScore([_]u3{ 1, 4, 1, 4, 1 }, .fours, 8);
}

test "fives" {
    try testScore([_]u3{ 1, 5, 3, 5, 3 }, .fives, 10);
}

test "yacht of 3s counted as fives" {
    try testScore([_]u3{ 3, 3, 3, 3, 3 }, .fives, 0);
}

test "sixes" {
    try testScore([_]u3{ 2, 3, 4, 5, 6 }, .sixes, 6);
}

test "four of a kind is not a full house" {
    try testScore([_]u3{ 1, 4, 4, 4, 4 }, .full_house, 0);
}

test "full house three small, two big" {
    try testScore([_]u3{ 5, 3, 3, 5, 3 }, .full_house, 19);
}

test "full house three small, two big, alternative order" {
    try testScore([_]u3{ 4, 4, 2, 2, 2 }, .full_house, 14);
}

test "full house two small, three big" {
    try testScore([_]u3{ 2, 2, 4, 4, 4 }, .full_house, 16);
}

test "full house two small, three big, alternative order" {
    try testScore([_]u3{ 3, 5, 5, 3, 5 }, .full_house, 21);
}

test "two pair is not a full house" {
    try testScore([_]u3{ 2, 2, 4, 4, 5 }, .full_house, 0);
}

test "yacht is not a full house" {
    try testScore([_]u3{ 2, 2, 2, 2, 2 }, .full_house, 0);
}

test "four of a kind" {
    try testScore([_]u3{ 6, 6, 4, 6, 6 }, .four_of_a_kind, 24);
}

test "four of a kind alternative order" {
    try testScore([_]u3{ 4, 4, 6, 4, 4 }, .four_of_a_kind, 16);
}

test "full house is not four of a kind" {
    try testScore([_]u3{ 3, 3, 3, 5, 5 }, .four_of_a_kind, 0);
}

test "yacht can be scored as four of a kind" {
    try testScore([_]u3{ 3, 3, 3, 3, 3 }, .four_of_a_kind, 12);
}

test "big straight as little straight" {
    try testScore([_]u3{ 6, 5, 4, 3, 2 }, .little_straight, 0);
}

test "four in order but not a little straight" {
    try testScore([_]u3{ 1, 1, 2, 3, 4 }, .little_straight, 0);
}

test "little straight" {
    try testScore([_]u3{ 3, 5, 4, 1, 2 }, .little_straight, 30);
}

test "minimum is 1, maximum is 5, but not a little straight" {
    try testScore([_]u3{ 1, 1, 3, 4, 5 }, .little_straight, 0);
}

test "no pairs but not a little straight" {
    try testScore([_]u3{ 1, 2, 3, 4, 6 }, .little_straight, 0);
}

test "big straight" {
    try testScore([_]u3{ 4, 6, 2, 5, 3 }, .big_straight, 30);
}

test "little straight as big straight" {
    try testScore([_]u3{ 1, 2, 3, 4, 5 }, .big_straight, 0);
}

test "no pairs but not a big straight" {
    try testScore([_]u3{ 6, 5, 4, 3, 1 }, .big_straight, 0);
}

test "choice" {
    try testScore([_]u3{ 3, 3, 5, 6, 6 }, .choice, 23);
}

test "yacht as choice" {
    try testScore([_]u3{ 2, 2, 2, 2, 2 }, .choice, 10);
}

test "not yacht" {
    try testScore([_]u3{ 1, 3, 3, 2, 5 }, .yacht, 0);
}

test "yacht" {
    try testScore([_]u3{ 5, 5, 5, 5, 5 }, .yacht, 50);
}
