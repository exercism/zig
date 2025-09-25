const std = @import("std");
const mem = std.mem;

pub fn canChain(allocator: mem.Allocator, stones: []const [2]u3) mem.Allocator.Error!bool {
    _ = allocator;
    _ = stones;
    @compileError("please implement the canChain function");
}
