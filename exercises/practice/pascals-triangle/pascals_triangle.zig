const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    _ = allocator;
    _ = count;
    @compileError("please implement the rows function");
}
