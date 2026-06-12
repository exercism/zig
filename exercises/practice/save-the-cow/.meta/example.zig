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
    word: []const u8,
    masked: []u8,

    /// Initializes a game with a copy of the given word, 9 remaining failures
    /// and every letter hidden.
    pub fn init(allocator: mem.Allocator, word: []const u8) mem.Allocator.Error!Game {
        const copy = try allocator.dupe(u8, word);
        errdefer allocator.free(copy);
        const masked = try allocator.alloc(u8, word.len);
        @memset(masked, '_');

        return .{
            .state = .ongoing,
            .remaining_failures = 9,
            .word = copy,
            .masked = masked,
        };
    }

    /// Frees the game.
    pub fn deinit(self: *Game, allocator: mem.Allocator) void {
        allocator.free(self.word);
        allocator.free(self.masked);
    }

    /// Processes one guessed letter.
    pub fn guess(self: *Game, letter: u8) Error!void {
        switch (self.state) {
            .ongoing => {},
            .win => return error.GameAlreadyWon,
            .lose => return error.GameAlreadyLost,
        }

        var correct = false;
        for (self.word, 0..) |c, i| {
            if (c == letter and self.masked[i] != letter) {
                self.masked[i] = letter;
                correct = true;
            }
        }

        if (correct) {
            if (mem.eql(u8, self.masked, self.word)) {
                self.state = .win;
            }
        } else if (self.remaining_failures > 0) {
            self.remaining_failures -= 1;
        } else {
            self.state = .lose;
        }
    }

    /// Returns the word with every unguessed letter replaced by an underscore.
    pub fn maskedWord(self: *const Game) []const u8 {
        return self.masked;
    }
};
