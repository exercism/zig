const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    _ = allocator;
    _ = value;
    @compileError("please implement the factors function");
}
