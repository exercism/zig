const std = @import("std");
const mem = std.mem;

pub const Item = struct {
    // This struct, as well as its fields and init method, needs to be implemented.

    pub fn init(weight: usize, value: usize) Item {
        _ = weight;
        _ = value;
        @compileError("please implement the init method");
    }
};

pub fn maximumValue(allocator: mem.Allocator, maximumWeight: usize, items: []const Item) !usize {
    _ = allocator;
    _ = maximumWeight;
    _ = items;
    @compileError("please implement the maximumValue function");
}
