const std = @import("std");

pub const QueenError = error{
    InvalidAttack,
};

pub const Queen = struct {
    row: u3,
    col: u3,

    pub fn init(row: u3, col: u3) Queen {
        return Queen{
            .row = row,
            .col = col,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        if (self.row == other.row and self.col == other.col) {
            return QueenError.InvalidAttack;
        }
        return self.row == other.row or self.col == other.col or
            absDiff(u8, self.row, other.row) == absDiff(u8, self.col, other.col);
    }
};

// Returns the absolute difference of `a` and `b`.
fn absDiff(comptime T: type, a: T, b: T) T {
    return if (a > b) a - b else b - a;
}
