const std = @import("std");
const mem = std.mem;

pub fn transpose(allocator: mem.Allocator, lines: []const []const u8) mem.Allocator.Error![][]u8 {
    _ = allocator;
    _ = lines;
    @compileError("please implement the transpose function");
}
