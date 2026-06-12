from lib import zstr

HEADER = """const State = save_the_cow.State;
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
"""


def gen_case(case):
    inp = case["input"]
    word = zstr(inp["word"])
    guesses = zstr("".join(inp["guesses"]))
    e = case["expected"]

    if "error" in e:
        err = "GameAlreadyLost" if "lost" in e["error"] else "GameAlreadyWon"
        fn = "testGameError"
        args = f"{word}, {guesses}, error.{err}"
    else:
        fn = "testGame"
        args = (
            f"{word}, {guesses}, .{e['state'].lower()}, "
            f"{zstr(e['maskedWord'])}, {e['remainingFailures']}"
        )

    return (
        "    try testing.checkAllAllocationFailures(\n"
        "        testing.allocator,\n"
        f"        {fn},\n"
        f"        .{{ {args} }},\n"
        "    );\n"
    )
