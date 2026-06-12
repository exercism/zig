const std = @import("std");
const testing = std.testing;

const save_the_cow = @import("save_the_cow.zig");
const State = save_the_cow.State;
const Game = save_the_cow.Game;

/// Plays `guesses` against `word` and checks the resulting game.
fn testGame(
    allocator: std.mem.Allocator,
    word: []const u8,
    guesses: []const u8,
    state: State,
    masked_word: []const u8,
    remaining_failures: u32,
) !void {
    var game = try Game.init(allocator, word);
    defer game.deinit(allocator);
    for (guesses) |letter| try game.guess(letter);
    try testing.expectEqual(state, game.state);
    try testing.expectEqualStrings(masked_word, game.maskedWord());
    try testing.expectEqual(remaining_failures, game.remaining_failures);
}

/// Plays `guesses` against `word` and checks that the final guess returns
/// `expected_error`.
fn testGameError(
    allocator: std.mem.Allocator,
    word: []const u8,
    guesses: []const u8,
    expected_error: anyerror,
) !void {
    var game = try Game.init(allocator, word);
    defer game.deinit(allocator);
    for (guesses[0 .. guesses.len - 1]) |letter| try game.guess(letter);
    try testing.expectError(expected_error, game.guess(guesses[guesses.len - 1]));
}

test "Initially 9 failures are allowed and no letters are guessed" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "", .ongoing, "____", 9 },
    );
}

test "After 10 failures the game is over" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "abcdefghij", .lose, "____", 0 },
    );
}

test "Losing with several correct guesses" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "toabcdefghij", .lose, "_oot", 0 },
    );
}

test "Feeding a correct letter removes underscores" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "t", .ongoing, "___t", 9 },
    );
}

test "Feeding a correct letter twice counts as a failure" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "tt", .ongoing, "___t", 8 },
    );
}

test "Guessing a repeated letter reveals all instances" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "tto", .ongoing, "_oot", 8 },
    );
}

test "Getting all the letters right makes for a win" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "ttol", .win, "loot", 8 },
    );
}

test "Winning on the last guess is still a win" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGame,
        .{ "loot", "abcdefghitol", .win, "loot", 0 },
    );
}

test "Guessing after a lose is error" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGameError,
        .{ "loot", "abcdefghijk", error.GameAlreadyLost },
    );
}

test "Guessing after a win is error" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testGameError,
        .{ "loot", "toll", error.GameAlreadyWon },
    );
}
