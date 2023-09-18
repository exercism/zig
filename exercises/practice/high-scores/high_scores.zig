pub const HighScores = struct {
    // Please implement the field(s) of this struct.
    foo: void,

    pub fn init(scores: []const u32) HighScores {
        _ = scores;
        @compileError("please implement the init method");
    }

    pub fn latest(self: HighScores) u32 {
        _ = self;
        @compileError("please implement the latest method");
    }

    pub fn personalBest(self: HighScores) u32 {
        _ = self;
        @compileError("please implement the personalBest method");
    }

    /// Writes (at most) the three highest scores from `self` into `buffer`.
    pub fn personalTopThree(self: HighScores, buffer: []u32) []u32 {
        _ = self;
        _ = buffer;
        @compileError("please implement the personalTopThree method");
    }
};
