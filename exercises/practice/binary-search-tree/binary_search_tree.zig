const std = @import("std");
const mem = std.mem;

pub const Node = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
};

pub const Tree = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    root: ?*Node,

    pub fn init(allocator: mem.Allocator) Tree {
        _ = allocator;
        @compileError("please implement the init method");
    }

    pub fn deinit(self: *Tree) void {
        _ = self;
        @compileError("please implement the deinit method");
    }

    pub fn insert(self: *Tree, data: i32) mem.Allocator.Error!void {
        _ = self;
        _ = data;
        @compileError("please implement the insert method");
    }

    pub fn sortedData(self: *Tree) mem.Allocator.Error![]i32 {
        _ = self;
        @compileError("please implement the sortedData method");
    }
};
