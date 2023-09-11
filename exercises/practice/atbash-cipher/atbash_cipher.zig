const std = @import("std");
const mem = std.mem;

/// Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = s;
    @compileError("please implement the encode function");
}

/// Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = s;
    @compileError("please implement the decode function");
}
