const std = @import("std");
const mem = std.mem;

pub const TraversalError = error{
    DifferentLengths,
    DifferentItems,
    NonUniqueItems,
};

pub const Node = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
};

pub const Tree = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    root: ?*Node,

    pub fn initFromTraversals(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8) (mem.Allocator.Error || TraversalError)!Tree {
        _ = allocator;
        _ = preorder;
        _ = inorder;
        @compileError("please implement the initFromTraversals method");
    }

    pub fn deinit(self: *Tree) void {
        _ = self;
        @compileError("please implement the deinit method");
    }
};
