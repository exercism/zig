const std = @import("std");
const math = std.math;

pub const QueenError = error{
    InitializationFailure,
    InvalidAttack,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row < 0 or row > 7 or col < 0 or col > 7) {
            return QueenError.InitializationFailure;
        }
        return .{
            .row = row,
            .col = col,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        if (self.row == other.row and self.col == other.col) {
            return QueenError.InvalidAttack;
        }
        return (self.row == other.row) or (self.col == other.col) or
            (math.absInt(self.row - other.row) catch unreachable ==
            math.absInt(self.col - other.col) catch unreachable);
    }
};
