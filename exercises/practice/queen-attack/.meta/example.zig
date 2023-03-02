const std = @import("std");
const math = std.math;

pub const QueenError = error{
    InitializationFailure,
    InvalidAttack,
};

pub const Queen = struct {
    x: i8,
    y: i8,

    pub fn init(x: i8, y: i8) QueenError!Queen {
        if (x < 0 or x > 7 or y < 0 or y > 7) {
            return QueenError.InitializationFailure;
        }
        return Queen{
            .x = x,
            .y = y,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        if (self.x == other.x and self.y == other.y) {
            return QueenError.InvalidAttack;
        }
        return (self.x == other.x) or (self.y == other.y) or
            (math.absInt(self.x - other.x) catch unreachable ==
            math.absInt(self.y - other.y) catch unreachable);
    }
};
