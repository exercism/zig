const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn rebase(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || BaseError)![]u32 {
    _ = allocator;
    _ = digits;
    _ = input_base;
    _ = output_base;
    @compileError("please implement the rebase function");
}
