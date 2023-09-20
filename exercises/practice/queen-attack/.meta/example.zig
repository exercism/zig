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

    /// Asserts that `a` and `b` are on different squares.
    pub fn canAttack(a: Queen, b: Queen) bool {
        std.debug.assert(a.row != b.row or a.col != b.col);
        return a.row == b.row or a.col == b.col or
            absDiff(u3, a.row, b.row) == absDiff(u3, a.col, b.col);
    }
};

// Returns the absolute difference of `a` and `b`.
fn absDiff(comptime T: type, a: T, b: T) T {
    return if (a > b) a - b else b - a;
}
