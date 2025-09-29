const std = @import("std");
const mem = std.mem;

pub const Node = struct {
    data: i32,
    left: ?*Node,
    right: ?*Node,

    fn init(allocator: mem.Allocator, data: i32) mem.Allocator.Error!*Node {
        const self = try allocator.create(Node);
        self.data = data;
        self.left = null;
        self.right = null;
        return self;
    }

    fn deinit(self: *Node, allocator: mem.Allocator) void {
        if (self.left) |child| {
            child.deinit(allocator);
        }
        if (self.right) |child| {
            child.deinit(allocator);
        }
        allocator.destroy(self);
    }

    fn insert(self: *Node, allocator: mem.Allocator, data: i32) mem.Allocator.Error!void {
        if (data <= self.data) {
            if (self.left) |child| {
                try child.insert(allocator, data);
            } else {
                self.left = try Node.init(allocator, data);
            }
        } else {
            if (self.right) |child| {
                try child.insert(allocator, data);
            } else {
                self.right = try Node.init(allocator, data);
            }
        }
    }

    fn write(self: *Node, list: *std.array_list.Managed(i32)) mem.Allocator.Error!void {
        if (self.left) |child| {
            try child.write(list);
        }
        try list.append(self.data);
        if (self.right) |child| {
            try child.write(list);
        }
    }
};

pub const Tree = struct {
    allocator: mem.Allocator,
    root: ?*Node = null,

    pub fn init(allocator: mem.Allocator) Tree {
        return .{
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Tree) void {
        if (self.root) |child| {
            child.deinit(self.allocator);
        }
    }

    pub fn insert(self: *Tree, data: i32) mem.Allocator.Error!void {
        if (self.root) |child| {
            try child.insert(self.allocator, data);
        } else {
            self.root = try Node.init(self.allocator, data);
        }
    }

    pub fn sortedData(self: *Tree) mem.Allocator.Error![]i32 {
        var list = std.array_list.Managed(i32).init(self.allocator);
        defer list.deinit();
        if (self.root) |child| {
            try child.write(&list);
        }
        return list.toOwnedSlice();
    }
};
