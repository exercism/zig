const std = @import("std");
const testing = std.testing;

const connect = @import("connect.zig");
const winner = connect.winner;

test "an empty board has no winner" {
    const board = [_][]const u8{
        ". . . . .", //
        " . . . . .", //
        "  . . . . .", //
        "   . . . . .", //
        "    . . . . .",
    };
    try testing.expectEqual('.', winner(testing.allocator, &board));
}

test "X can win on a 1x1 board" {
    const board = [_][]const u8{"X"};
    try testing.expectEqual('X', winner(testing.allocator, &board));
}

test "O can win on a 1x1 board" {
    const board = [_][]const u8{"O"};
    try testing.expectEqual('O', winner(testing.allocator, &board));
}

test "only edges does not make a winner" {
    const board = [_][]const u8{
        "O O O X", //
        " X . . X", //
        "  X . . X", //
        "   X O O O",
    };
    try testing.expectEqual('.', winner(testing.allocator, &board));
}

test "illegal diagonal does not make a winner" {
    const board = [_][]const u8{
        "X O . .", //
        " O X X X", //
        "  O X O .", //
        "   . O X .", //
        "    X X O O",
    };
    try testing.expectEqual('.', winner(testing.allocator, &board));
}

test "nobody wins crossing adjacent angles" {
    const board = [_][]const u8{
        "X . . .", //
        " . X O .", //
        "  O . X O", //
        "   . O . X", //
        "    . . O .",
    };
    try testing.expectEqual('.', winner(testing.allocator, &board));
}

test "X wins crossing from left to right" {
    const board = [_][]const u8{
        ". O . .", //
        " O X X X", //
        "  O X O .", //
        "   X X O X", //
        "    . O X .",
    };
    try testing.expectEqual('X', winner(testing.allocator, &board));
}

test "O wins crossing from top to bottom" {
    const board = [_][]const u8{
        ". O . .", //
        " O X X X", //
        "  O O O .", //
        "   X X O X", //
        "    . O X .",
    };
    try testing.expectEqual('O', winner(testing.allocator, &board));
}

test "X wins using a convoluted path" {
    const board = [_][]const u8{
        ". X X . .", //
        " X . X . X", //
        "  . X . X .", //
        "   . X X . .", //
        "    O O O O O",
    };
    try testing.expectEqual('X', winner(testing.allocator, &board));
}

test "X wins using a spiral path" {
    const board = [_][]const u8{
        "O X X X X X X X X", //
        " O X O O O O O O O", //
        "  O X O X X X X X O", //
        "   O X O X O O O X O", //
        "    O X O X X X O X O", //
        "     O X O O O X O X O", //
        "      O X X X X X O X O", //
        "       O O O O O O O X O", //
        "        X X X X X X X X O",
    };
    try testing.expectEqual('X', winner(testing.allocator, &board));
}
