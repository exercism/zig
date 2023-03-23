const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const usize, limit: usize) !usize {
    _ = allocator;
    _ = factors;
    _ = limit;
    @compileError("please implement the sum function");
}
