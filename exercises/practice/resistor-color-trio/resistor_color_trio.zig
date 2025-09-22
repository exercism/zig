const std = @import("std");
const mem = std.mem;

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = colors;
    @compileError("please implement the label function");
}
