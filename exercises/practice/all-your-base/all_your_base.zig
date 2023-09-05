const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn rebase(
    allocator: mem.Allocator,
    digits: []const u32,
    from_base: u32,
    to_base: u32,
) (mem.Allocator.Error || BaseError)![]u32 {
    _ = allocator;
    _ = digits;
    _ = from_base;
    _ = to_base;
    @compileError("please implement the rebase function");
}
