pub const Error = error{ GameOver, PinCountExceeded, GameIncomplete };

pub const Strikes = enum {
    two,
    one,
    half,
    zero,
};

pub const Game = struct {
    total: u32,
    frames: u32,
    pins: u32,
    strikes: Strikes,

    /// Initializes a Game.
    pub fn init() Game {
        return .{
            .total = 0,
            .frames = 0,
            .pins = 0,
            .strikes = .zero,
        };
    }

    pub fn isOver(self: Game) bool {
        // After ten frames, the game continues while a strike or spare
        // bonus is still owed.
        return self.frames >= 10 and self.strikes == .zero;
    }

    /// Records a roll that knocks down `pins` pins.
    pub fn roll(self: *Game, pins: u5) Error!void {
        if (self.isOver()) {
            return Error.GameOver;
        }

        const limit: u32 = if (self.pins == 0) 10 else self.pins;
        if (pins > limit) {
            return Error.PinCountExceeded;
        }

        if (self.frames < 10) {
            self.total += pins;
        }
        switch (self.strikes) {
            .two => {
                self.total += 2 * pins;
            },
            .one, .half => {
                self.total += pins;
            },
            .zero => {},
        }

        if (self.pins == 0) {
            self.pins = 10 - pins;

            if (pins == 10) {
                if (self.frames < 10) {
                    if ((self.strikes == .two) or (self.strikes == .one)) {
                        self.strikes = .two;
                    } else {
                        self.strikes = .one;
                    }
                } else {
                    if ((self.strikes == .two) or (self.strikes == .one)) {
                        self.strikes = .half;
                    } else {
                        self.strikes = .zero;
                    }
                }
                self.frames += 1;
            } else {
                if ((self.strikes == .two) or (self.strikes == .one)) {
                    self.strikes = .half;
                } else {
                    self.strikes = .zero;
                }
            }
        } else {
            if (pins == self.pins) {
                self.strikes = if (self.frames < 10) .half else .zero;
            } else {
                self.strikes = .zero;
            }
            self.frames += 1;
            self.pins = 0;
        }
    }

    /// Returns the score of a complete game.
    pub fn score(self: Game) Error!u32 {
        if (!self.isOver()) {
            return Error.GameIncomplete;
        }

        return self.total;
    }
};
