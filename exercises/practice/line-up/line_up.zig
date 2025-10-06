const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    _ = allocator;
    _ = name;
    _ = number;
    @compileError("please implement the format function");
}
