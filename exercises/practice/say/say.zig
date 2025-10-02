const std = @import("std");
const mem = std.mem;

pub const SayError = error{
    OutOfRange,
};

pub fn say(allocator: mem.Allocator, number: i41) (mem.Allocator.Error || SayError)![]u8 {
    _ = allocator;
    _ = number;
    @compileError("please implement the say function");
}
