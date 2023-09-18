const std = @import("std");
const testing = std.testing;

const high_scores = @import("high_scores.zig");
const HighScores = high_scores.HighScores;

test "list of scores" {
    const expected = [_]u32{ 30, 50, 20, 70 };
    const scores = [_]u32{ 30, 50, 20, 70 };
    const h = HighScores.init(&scores);
    const actual = h.scores;
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "latest score" {
    const expected: u32 = 30;
    const scores = [_]u32{ 100, 0, 90, 30 };
    const h = HighScores.init(&scores);
    const actual = h.latest();
    try testing.expectEqual(expected, actual);
}

test "personal best" {
    const expected: u32 = 100;
    const scores = [_]u32{ 40, 100, 70 };
    const h = HighScores.init(&scores);
    const actual = h.personalBest();
    try testing.expectEqual(expected, actual);
}

test "personal top three from a list of scores" {
    const expected = [_]u32{ 100, 90, 70 };
    const scores = [_]u32{ 10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    const actual = h.personalTopThree(&buffer);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "personal top highest to lowest" {
    const expected = [_]u32{ 30, 20, 10 };
    const scores = [_]u32{ 20, 10, 30 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    const actual = h.personalTopThree(&buffer);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "personal top when there is a tie" {
    const expected = [_]u32{ 40, 40, 30 };
    const scores = [_]u32{ 40, 20, 40, 30 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    const actual = h.personalTopThree(&buffer);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "personal top when there are less than 3" {
    const expected = [_]u32{ 70, 30 };
    const scores = [_]u32{ 30, 70 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    const actual = h.personalTopThree(&buffer);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "personal top when there is only one" {
    const expected = [_]u32{40};
    const scores = [_]u32{40};
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    const actual = h.personalTopThree(&buffer);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "latest score after personal top scores" {
    const expected: u32 = 30;
    const scores = [_]u32{ 70, 50, 20, 30 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    _ = h.personalTopThree(&buffer);
    const actual = h.latest();
    try testing.expectEqual(expected, actual);
}

test "scores after personal top scores" {
    const expected = [_]u32{ 30, 50, 20, 70 };
    const scores = [_]u32{ 30, 50, 20, 70 };
    const h = HighScores.init(&scores);
    var buffer: [scores.len]u32 = undefined;
    _ = h.personalTopThree(&buffer);
    const actual = h.scores;
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "latest score after personal best" {
    const expected: u32 = 30;
    const scores = [_]u32{ 20, 70, 15, 25, 30 };
    const h = HighScores.init(&scores);
    _ = h.personalBest();
    const actual = h.latest();
    try testing.expectEqual(expected, actual);
}

test "scores after personal best" {
    const expected = [_]u32{ 20, 70, 15, 25, 30 };
    const scores = [_]u32{ 20, 70, 15, 25, 30 };
    const h = HighScores.init(&scores);
    _ = h.personalBest();
    const actual = h.scores;
    try testing.expectEqualSlices(u32, &expected, actual);
}
