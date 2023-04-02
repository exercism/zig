const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    _ = allocator;
    _ = s;
    @compileError("please implement the isBalanced function");
}
