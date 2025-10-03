const std = @import("std");
const mem = std.mem;

/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    _ = allocator;
    _ = s;
    _ = index;
    @compileError("please implement the row function");
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    _ = allocator;
    _ = s;
    _ = index;
    @compileError("please implement the column function");
}
