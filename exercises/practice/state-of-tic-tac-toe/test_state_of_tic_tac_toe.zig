const std = @import("std");
const testing = std.testing;

const state_of_tic_tac_toe = @import("state_of_tic_tac_toe.zig");
const GameState = state_of_tic_tac_toe.GameState;

test "Won games-Finished game where X won via left column victory" {
    const board = [_][]const u8{
        "XOO", //
        "X  ", //
        "X  ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via middle column victory" {
    const board = [_][]const u8{
        "OXO", //
        " X ", //
        " X ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via right column victory" {
    const board = [_][]const u8{
        "OOX", //
        "  X", //
        "  X", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via left column victory" {
    const board = [_][]const u8{
        "OXX", //
        "OX ", //
        "O  ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via middle column victory" {
    const board = [_][]const u8{
        "XOX", //
        " OX", //
        " O ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via right column victory" {
    const board = [_][]const u8{
        "XXO", //
        " XO", //
        "  O", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via top row victory" {
    const board = [_][]const u8{
        "XXX", //
        "XOO", //
        "O  ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via middle row victory" {
    const board = [_][]const u8{
        "O  ", //
        "XXX", //
        " O ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via bottom row victory" {
    const board = [_][]const u8{
        " OO", //
        "O X", //
        "XXX", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via top row victory" {
    const board = [_][]const u8{
        "OOO", //
        "XXO", //
        "XX ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via middle row victory" {
    const board = [_][]const u8{
        "XX ", //
        "OOO", //
        "X  ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via bottom row victory" {
    const board = [_][]const u8{
        "XOX", //
        " XX", //
        "OOO", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via falling diagonal victory" {
    const board = [_][]const u8{
        "XOO", //
        " X ", //
        "  X", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via rising diagonal victory" {
    const board = [_][]const u8{
        "O X", //
        "OX ", //
        "X  ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via falling diagonal victory" {
    const board = [_][]const u8{
        "OXX", //
        "OOX", //
        "X O", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where O won via rising diagonal victory" {
    const board = [_][]const u8{
        "  O", //
        " OX", //
        "OXX", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via a row and a column victory" {
    const board = [_][]const u8{
        "XXX", //
        "XOO", //
        "XOO", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Won games-Finished game where X won via two diagonal victories" {
    const board = [_][]const u8{
        "XOX", //
        "OXO", //
        "XOX", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.win, actual);
}

test "Drawn games-Draw" {
    const board = [_][]const u8{
        "XOX", //
        "XXO", //
        "OXO", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.draw, actual);
}

test "Drawn games-Another draw" {
    const board = [_][]const u8{
        "XXO", //
        "OXX", //
        "XOO", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.draw, actual);
}

test "Ongoing games-Ongoing game: one move in" {
    const board = [_][]const u8{
        "   ", //
        "X  ", //
        "   ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.ongoing, actual);
}

test "Ongoing games-Ongoing game: two moves in" {
    const board = [_][]const u8{
        "O  ", //
        " X ", //
        "   ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.ongoing, actual);
}

test "Ongoing games-Ongoing game: five moves in" {
    const board = [_][]const u8{
        "X  ", //
        " XO", //
        "OX ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    try testing.expectEqual(GameState.ongoing, actual);
}

test "Invalid boards-Invalid board: X went twice" {
    const board = [_][]const u8{
        "XX ", //
        "   ", //
        "   ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    // Wrong turn order: X went twice
    try testing.expectEqual(GameState.impossible, actual);
}

test "Invalid boards-Invalid board: O started" {
    const board = [_][]const u8{
        "OOX", //
        "   ", //
        "   ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    // Wrong turn order: O started
    try testing.expectEqual(GameState.impossible, actual);
}

test "Invalid boards-Invalid board: X won and O kept playing" {
    const board = [_][]const u8{
        "XXX", //
        "OOO", //
        "   ", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    // Impossible board: game should have ended after the game was won
    try testing.expectEqual(GameState.impossible, actual);
}

test "Invalid boards-Invalid board: players kept playing after a win" {
    const board = [_][]const u8{
        "XXX", //
        "OOO", //
        "XOX", //
    };
    const actual = state_of_tic_tac_toe.gameState(&board);
    // Impossible board: game should have ended after the game was won
    try testing.expectEqual(GameState.impossible, actual);
}
