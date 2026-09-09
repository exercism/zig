fn normalize(raw_minutes: i32) i32 {
    const minutes_per_day = 24 * 60;
    return @mod(raw_minutes, minutes_per_day);
}

pub const Clock = struct {
    total_minutes: i32,

    /// Initializes a Clock, normalizing the given hour and minute.
    pub fn init(hour: i32, minute: i32) Clock {
        return .{
            .total_minutes = normalize(hour * 60 + minute),
        };
    }

    /// Moves the clock forwards by `minutes` minutes.
    pub fn advance(self: *Clock, minutes: i32) void {
        self.total_minutes = normalize(self.total_minutes + minutes);
    }

    /// Moves the clock backwards by `minutes` minutes.
    pub fn rewind(self: *Clock, minutes: i32) void {
        self.total_minutes = normalize(self.total_minutes - minutes);
    }

    /// Renders the time as "hh:mm".
    pub fn toString(self: Clock) [5]u8 {
        const h: u8 = @intCast(@divFloor(self.total_minutes, 60));
        const m: u8 = @intCast(@mod(self.total_minutes, 60));
        return .{
            h / 10 + '0',
            h % 10 + '0',
            ':',
            m / 10 + '0',
            m % 10 + '0',
        };
    }

    /// Returns whether two clocks show the same time.
    pub fn eql(self: Clock, other: Clock) bool {
        return self.total_minutes == other.total_minutes;
    }
};
