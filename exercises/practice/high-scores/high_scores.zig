pub const HighScores = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(scores: []const i32) HighScores {
        _ = scores;
        @compileError("please implement the init method");
    }

    pub fn latest(self: *const HighScores) ?i32 {
        _ = self;
        @compileError("please implement the latest method");
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        _ = self;
        @compileError("please implement the personalBest method");
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        _ = self;
        @compileError("please implement the personalTopThree method");
    }
};
