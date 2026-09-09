pub const Error = error{ GameOver, PinCountExceeded, GameIncomplete };

pub const Game = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    /// Initializes a Game.
    pub fn init() Game {
        @compileError("please implement the init function");
    }

    /// Records a roll that knocks down `pins` pins.
    pub fn roll(self: *Game, pins: u4) Error!void {
        _ = self;
        _ = pins;
        @compileError("please implement the roll function");
    }

    /// Returns the score of a complete game.
    pub fn score(self: Game) Error!u32 {
        _ = self;
        @compileError("please implement the score function");
    }
};
