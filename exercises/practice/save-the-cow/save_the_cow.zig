const std = @import("std");
const mem = std.mem;

pub const State = enum {
    ongoing,
    win,
    lose,
};

pub const Error = error{ GameAlreadyWon, GameAlreadyLost };

pub const Game = struct {
    state: State,
    remaining_failures: u32,
    // Additional fields need to be added.

    /// Initializes a game with a copy of the given word, 9 remaining failures
    /// and every letter hidden.
    pub fn init(allocator: mem.Allocator, word: []const u8) mem.Allocator.Error!Game {
        _ = allocator;
        _ = word;
        @compileError("please implement the init function");
    }

    /// Frees the game.
    pub fn deinit(self: *Game, allocator: mem.Allocator) void {
        _ = self;
        _ = allocator;
        @compileError("please implement the deinit function");
    }

    /// Processes one guessed letter.
    pub fn guess(self: *Game, letter: u8) Error!void {
        _ = self;
        _ = letter;
        @compileError("please implement the guess function");
    }

    /// Returns the word with every unguessed letter replaced by an underscore.
    pub fn maskedWord(self: *const Game) []const u8 {
        _ = self;
        @compileError("please implement the maskedWord function");
    }
};
