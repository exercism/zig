pub const HighScores = struct {
    // Please implement the field(s) of this struct.
    foo: void,

    pub fn init(s: []const u32) HighScores {
        _ = s;
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

    pub fn personalTopThree(self: HighScores, buffer: []u32) []u32 {
        _ = self;
        _ = buffer;
        @compileError("please implement the personalTopThree method");
    }
};
