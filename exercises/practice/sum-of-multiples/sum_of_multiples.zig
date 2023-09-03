const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u32 {
    _ = allocator;
    _ = factors;
    _ = limit;
    @compileError("please implement the sum function");
}
