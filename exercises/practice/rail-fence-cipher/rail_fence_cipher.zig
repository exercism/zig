const std = @import("std");
const mem = std.mem;

/// Encodes `msg` using the rail fence cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = msg;
    _ = rails;
    @compileError("please implement the encode function");
}

/// Decodes `msg` using the rail fence cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = msg;
    _ = rails;
    @compileError("please implement the decode function");
}
