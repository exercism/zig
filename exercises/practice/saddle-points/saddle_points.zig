const std = @import("std");
const mem = std.mem;

pub const Point = struct {
    row: u16,
    column: u16,
};

pub fn saddlePoints(comptime m: usize, comptime n: usize, allocator: mem.Allocator, matrix: [m][n]i32) mem.Allocator.Error![]Point {
    _ = allocator;
    _ = matrix;
    @compileError("please implement the saddlePoints function");
}
