const std = @import("std");
const testing = std.testing;

const state_of_tic_tac_toe = @import("state_of_tic_tac_toe.zig");

const GameState = state_of_tic_tac_toe.GameState;

fn testGameState(board: []const []const u8, expected: GameState) !void {
    const actual = state_of_tic_tac_toe.gameState(board);
    try testing.expectEqual(expected, actual);
}

test "Won games-Finished game where X won via left column victory" {
    const board = [_][]const u8{
        "XOO", //
        "X  ", //
        "X  ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via middle column victory" {
    const board = [_][]const u8{
        "OXO", //
        " X ", //
        " X ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via right column victory" {
    const board = [_][]const u8{
        "OOX", //
        "  X", //
        "  X", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via left column victory" {
    const board = [_][]const u8{
        "OXX", //
        "OX ", //
        "O  ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via middle column victory" {
    const board = [_][]const u8{
        "XOX", //
        " OX", //
        " O ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via right column victory" {
    const board = [_][]const u8{
        "XXO", //
        " XO", //
        "  O", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via top row victory" {
    const board = [_][]const u8{
        "XXX", //
        "XOO", //
        "O  ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via middle row victory" {
    const board = [_][]const u8{
        "O  ", //
        "XXX", //
        " O ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via bottom row victory" {
    const board = [_][]const u8{
        " OO", //
        "O X", //
        "XXX", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via top row victory" {
    const board = [_][]const u8{
        "OOO", //
        "XXO", //
        "XX ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via middle row victory" {
    const board = [_][]const u8{
        "XX ", //
        "OOO", //
        "X  ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via bottom row victory" {
    const board = [_][]const u8{
        "XOX", //
        " XX", //
        "OOO", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via falling diagonal victory" {
    const board = [_][]const u8{
        "XOO", //
        " X ", //
        "  X", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via rising diagonal victory" {
    const board = [_][]const u8{
        "O X", //
        "OX ", //
        "X  ", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via falling diagonal victory" {
    const board = [_][]const u8{
        "OXX", //
        "OOX", //
        "X O", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where O won via rising diagonal victory" {
    const board = [_][]const u8{
        "  O", //
        " OX", //
        "OXX", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via a row and a column victory" {
    const board = [_][]const u8{
        "XXX", //
        "XOO", //
        "XOO", //
    };
    try testGameState(&board, GameState.win);
}

test "Won games-Finished game where X won via two diagonal victories" {
    const board = [_][]const u8{
        "XOX", //
        "OXO", //
        "XOX", //
    };
    try testGameState(&board, GameState.win);
}

test "Drawn games-Draw" {
    const board = [_][]const u8{
        "XOX", //
        "XXO", //
        "OXO", //
    };
    try testGameState(&board, GameState.draw);
}

test "Drawn games-Another draw" {
    const board = [_][]const u8{
        "XXO", //
        "OXX", //
        "XOO", //
    };
    try testGameState(&board, GameState.draw);
}

test "Ongoing games-Ongoing game: one move in" {
    const board = [_][]const u8{
        "   ", //
        "X  ", //
        "   ", //
    };
    try testGameState(&board, GameState.ongoing);
}

test "Ongoing games-Ongoing game: two moves in" {
    const board = [_][]const u8{
        "O  ", //
        " X ", //
        "   ", //
    };
    try testGameState(&board, GameState.ongoing);
}

test "Ongoing games-Ongoing game: five moves in" {
    const board = [_][]const u8{
        "X  ", //
        " XO", //
        "OX ", //
    };
    try testGameState(&board, GameState.ongoing);
}

test "Invalid boards-Invalid board: X went twice" {
    const board = [_][]const u8{
        "XX ", //
        "   ", //
        "   ", //
    };
    // Wrong turn order: X went twice
    try testGameState(&board, GameState.impossible);
}

test "Invalid boards-Invalid board: O started" {
    const board = [_][]const u8{
        "OOX", //
        "   ", //
        "   ", //
    };
    // Wrong turn order: O started
    try testGameState(&board, GameState.impossible);
}

test "Invalid boards-Invalid board: X won and O kept playing" {
    const board = [_][]const u8{
        "XXX", //
        "OOO", //
        "   ", //
    };
    // Impossible board: game should have ended after the game was won
    try testGameState(&board, GameState.impossible);
}

test "Invalid boards-Invalid board: players kept playing after a win" {
    const board = [_][]const u8{
        "XXX", //
        "OOO", //
        "XOX", //
    };
    // Impossible board: game should have ended after the game was won
    try testGameState(&board, GameState.impossible);
}

test "Invalid boards-Invalid board: O kept playing after X wins" {
    const board = [_][]const u8{
        "OO ", //
        "XXX", //
        " O ", //
    };
    // Impossible board: game should have ended after the game was won
    try testGameState(&board, GameState.impossible);
}

test "Invalid boards-Invalid board: X kept playing after O wins" {
    const board = [_][]const u8{
        "XX ", //
        "OOO", //
        " XX", //
    };
    // Impossible board: game should have ended after the game was won
    try testGameState(&board, GameState.impossible);
}
