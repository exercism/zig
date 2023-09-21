const std = @import("std");

pub const ChessboardError = error{IndexOutOfBounds};

pub fn square(index: u7) ChessboardError!u64 {
    const number_of_chess_squares = 64;
    if (index > number_of_chess_squares or index == 0) {
        return ChessboardError.IndexOutOfBounds;
    }
    return @as(u64, 1) << @as(u6, @truncate(index - 1));
}

pub fn total() u64 {
    return std.math.maxInt(u64);
}
