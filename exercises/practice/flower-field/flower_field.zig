const std = @import("std");
const mem = std.mem;

pub fn annotate(allocator: mem.Allocator, garden: []const []const u8) mem.Allocator.Error![][]u8 {
    _ = allocator;
    _ = garden;
    @compileError("please implement the annotate function");
}
