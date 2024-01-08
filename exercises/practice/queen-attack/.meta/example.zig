const std = @import("std");

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
        const row_diff = self.row - other.row;
        const col_diff = self.col - other.col;
        return (row_diff == 0) or (col_diff == 0) or (row_diff == col_diff) or (row_diff == -col_diff);
    }
};
