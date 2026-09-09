pub const Clock = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    /// Initializes a Clock, normalizing the given hour and minute.
    pub fn init(hour: i32, minute: i32) Clock {
        _ = hour;
        _ = minute;
        @compileError("please implement the init function");
    }

    /// Moves the clock forwards by `minutes` minutes.
    pub fn advance(self: *Clock, minutes: i32) void {
        _ = self;
        _ = minutes;
        @compileError("please implement the advance function");
    }

    /// Moves the clock backwards by `minutes` minutes.
    pub fn rewind(self: *Clock, minutes: i32) void {
        _ = self;
        _ = minutes;
        @compileError("please implement the rewind function");
    }

    /// Renders the time as "hh:mm".
    pub fn toString(self: Clock) [5]u8 {
        _ = self;
        @compileError("please implement the toString function");
    }

    /// Returns whether two clocks show the same time.
    pub fn eql(self: Clock, other: Clock) bool {
        _ = self;
        _ = other;
        @compileError("please implement the eql function");
    }
};
