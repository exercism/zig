const std = @import("std");
const mem = std.mem;

pub const TraversalError = error{
    DifferentLengths,
    DifferentItems,
    NonUniqueItems,
};

pub const Node = struct {
    left: ?*Node,
    right: ?*Node,
    data: i32,

    fn init(allocator: mem.Allocator, left: ?*Node, right: ?*Node, data: i32) mem.Allocator.Error!*Node {
        const self = try allocator.create(Node);
        self.left = left;
        self.right = right;
        self.data = data;
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

    fn write(self: *const Node, list: *std.array_list.Managed(i32)) mem.Allocator.Error!void {
        if (self.left) |child| {
            try child.write(list);
        }
        if (self.right) |child| {
            try child.write(list);
        }
        try list.append(self.data);
    }
};

pub const Tree = struct {
    allocator: mem.Allocator,
    root: ?*Node,

    pub fn initFromTraversals(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8) (mem.Allocator.Error || TraversalError)!Tree {
        if (preorder.len != inorder.len) {
            return TraversalError.DifferentLengths;
        }
        if (preorder.len == 0) {
            return .{
                .allocator = allocator,
                .root = null,
            };
        }
        if (repeats(preorder) or repeats(inorder)) {
            return TraversalError.NonUniqueItems;
        }

        var preorder_index: usize = 0;
        var inorder_index: usize = 0;
        return .{
            .allocator = allocator,
            .root = try traverse(allocator, preorder, inorder, &preorder_index, &inorder_index, null),
        };
    }

    pub fn deinit(self: *Tree) void {
        if (self.root) |child| {
            child.deinit(self.allocator);
        }
    }
};

fn repeats(items: []const u8) bool {
    for (1..(items.len)) |i| {
        for (0..i) |j| {
            if (items[j] == items[i]) {
                return true;
            }
        }
    }
    return false;
}

fn traverse(allocator: mem.Allocator, preorder: []const u8, inorder: []const u8, preorder_index: *usize, inorder_index: *usize, successor: ?u8) (mem.Allocator.Error || TraversalError)!?*Node {
    if (successor) |s| {
        if (inorder_index.* < inorder.len and inorder[inorder_index.*] == s) {
            return null; // our parent has empty left subtree
        }
    }
    if (preorder_index.* == preorder.len) {
        return null;
    }

    const data = preorder[preorder_index.*];
    preorder_index.* += 1;

    const left = try traverse(allocator, preorder, inorder, preorder_index, inorder_index, data);
    errdefer {
        if (left) |child| {
            child.deinit(allocator);
        }
    }

    if (inorder_index.* == inorder.len or inorder[inorder_index.*] != data) {
        return TraversalError.DifferentItems;
    }
    inorder_index.* += 1;

    const right = try traverse(allocator, preorder, inorder, preorder_index, inorder_index, successor);
    errdefer {
        if (right) |child| {
            child.deinit(allocator);
        }
    }

    return try Node.init(allocator, left, right, data);
}
