const std = @import("std");
const testing = std.testing;

const high_scores = @import("high_scores.zig");
const HighScores = high_scores.HighScores;

test "Latest score" {
    const scores = &[_]i32{ 100, 0, 90, 30 };
    try testing.expectEqual(30, HighScores.init(scores).latest());
}

test "Personal best" {
    const scores = &[_]i32{ 40, 100, 70 };
    try testing.expectEqual(100, HighScores.init(scores).personalBest());
}

test "Top 3 scores-Personal top three from a list of scores" {
    const scores = &[_]i32{ 10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70 };
    try testing.expectEqualSlices(i32, &[_]i32{ 100, 90, 70 }, HighScores.init(scores).personalTopThree());
}

test "Top 3 scores-Personal top highest to lowest" {
    const scores = &[_]i32{ 20, 10, 30 };
    try testing.expectEqualSlices(i32, &[_]i32{ 30, 20, 10 }, HighScores.init(scores).personalTopThree());
}

test "Top 3 scores-Personal top when there is a tie" {
    const scores = &[_]i32{ 40, 20, 40, 30 };
    try testing.expectEqualSlices(i32, &[_]i32{ 40, 40, 30 }, HighScores.init(scores).personalTopThree());
}

test "Top 3 scores-Personal top when there are less than 3" {
    const scores = &[_]i32{ 30, 70 };
    try testing.expectEqualSlices(i32, &[_]i32{ 70, 30 }, HighScores.init(scores).personalTopThree());
}

test "Top 3 scores-Personal top when there is only one" {
    const scores = &[_]i32{40};
    try testing.expectEqualSlices(i32, &[_]i32{40}, HighScores.init(scores).personalTopThree());
}
