const std = @import("std");
const mem = std.mem;

pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = s;
    @compileError("please implement the encode function");
}

pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = s;
    @compileError("please implement the decode function");
}
