const std = @import("std");

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

pub fn rebase(
    buffer: []u32,
    digits: []const u32,
    from_base: u32,
    to_base: u32,
) BaseError![]u32 {
    _ = buffer;
    _ = digits;
    _ = from_base;
    _ = to_base;
    @compileError("please implement the rebase function");
}
