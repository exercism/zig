const std = @import("std");
const mem = std.mem;

pub fn spiral(allocator: mem.Allocator, size: u16) mem.Allocator.Error![][]u16 {
    _ = allocator;
    _ = size;
    @compileError("please implement the spiral function");
}
