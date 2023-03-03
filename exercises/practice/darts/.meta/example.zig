const std = @import("std");
const math = std.math;

pub const Coordinate = struct {
    x_coord: f32,
    y_coord: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{
            .x_coord = x_coord,
            .y_coord = y_coord,
        };
    }

    pub fn score(self: Coordinate) usize {
        const d = math.sqrt(self.x_coord * self.x_coord +
            self.y_coord * self.y_coord);
        if (d > 10) {
            return 0;
        } else if (d > 5) {
            return 1;
        } else if (d > 1) {
            return 5;
        }
        return 10;
    }
};
