pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x: f32, y: f32) Coordinate {
        return .{ .x = x, .y = y };
    }

    pub fn score(self: Coordinate) u32 {
        const n = (self.x * self.x) + (self.y * self.y); // The distance squared.
        return if (n <= 1) 10 else if (n <= 25) 5 else if (n <= 100) 1 else 0;
    }
};
