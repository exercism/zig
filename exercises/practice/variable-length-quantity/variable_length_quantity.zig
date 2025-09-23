const std = @import("std");
const mem = std.mem;

pub const DecodeError = error{
    IncompleteSequence,
};

pub fn encode(allocator: mem.Allocator, integers: []const u32) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = integers;
    @compileError("please implement the encode function");
}

pub fn decode(allocator: mem.Allocator, integers: []const u8) (mem.Allocator.Error || DecodeError)![]u32 {
    _ = allocator;
    _ = integers;
    @compileError("please implement the decode function");
}
