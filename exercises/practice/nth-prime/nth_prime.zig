const std = @import("std");
const mem = std.mem;

pub fn prime(allocator: mem.Allocator, number: usize) !usize {
    _ = allocator;
    _ = number;
    @compileError("please implement the prime function");
}
