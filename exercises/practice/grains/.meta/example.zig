const std = @import("std");
const math = std.math;

pub const ChessboardError = error{IndexOutOfBounds};

const NUMBER_OF_CHESS_SQUARES = 64;

pub fn square(index: isize) ChessboardError!u64 {
    if (index > NUMBER_OF_CHESS_SQUARES or index <= 0) {
        return ChessboardError.IndexOutOfBounds;
    }
    return @as(u64, 1) << @truncate(u6, @bitCast(usize, index) - 1);
}

pub fn total() u64 {
    return math.maxInt(u64);
}
