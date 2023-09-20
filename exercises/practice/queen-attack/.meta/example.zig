const std = @import("std");

pub const Queen = struct {
    row: u3,
    col: u3,

    pub fn init(row: u3, col: u3) Queen {
        return Queen{
            .row = row,
            .col = col,
        };
    }

    /// Asserts that `self` and `other` are on different squares.
    pub fn canAttack(self: Queen, other: Queen) bool {
        std.debug.assert(self.row != other.row or self.col != other.col);
        return self.row == other.row or self.col == other.col or
            absDiff(u3, self.row, other.row) == absDiff(u3, self.col, other.col);
    }
};

// Returns the absolute difference of `a` and `b`.
fn absDiff(comptime T: type, a: T, b: T) T {
    return if (a > b) a - b else b - a;
}
