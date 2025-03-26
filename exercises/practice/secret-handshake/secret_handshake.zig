const std = @import("std");
const mem = std.mem;

// An enum `Signal`, needs to be implemented.
pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    _ = allocator;
    _ = number;
    @compileError("please implement the calculateHandshake function");
}
