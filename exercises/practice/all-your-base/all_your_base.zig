const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn rebase(
    allocator: mem.Allocator,
    digits: []const usize,
    from_base: usize,
    to_base: usize,
) (mem.Allocator.Error || BaseError)![]usize {
    _ = allocator;
    _ = digits;
    _ = from_base;
    _ = to_base;
    @compileError("please implement the rebase function");
}
