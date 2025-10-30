const std = @import("std");
const testing = std.testing;

const satellite = @import("satellite.zig");
const Tree = satellite.Tree;
const TraversalError = satellite.TraversalError;

test "Empty tree" {
    const preorder = [_]u8{};
    const inorder = [_]u8{};
    var tree = try Tree.initFromTraversals(testing.allocator, &preorder, &inorder);
    defer tree.deinit();
    try testing.expectEqual(null, tree.root);
}

test "Tree with one item" {
    const preorder = [_]u8{'a'};
    const inorder = [_]u8{'a'};
    var tree = try Tree.initFromTraversals(testing.allocator, &preorder, &inorder);
    defer tree.deinit();
    if (tree.root) |o| {
        try testing.expectEqual('a', o.data);
        try testing.expectEqual(null, o.left);
        try testing.expectEqual(null, o.right);
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "Tree with many items" {
    const preorder = [_]u8{ 'a', 'i', 'x', 'f', 'r' };
    const inorder = [_]u8{ 'i', 'a', 'f', 'x', 'r' };
    var tree = try Tree.initFromTraversals(testing.allocator, &preorder, &inorder);
    defer tree.deinit();
    if (tree.root) |o| {
        try testing.expectEqual('a', o.data);
        if (o.left) |l| {
            try testing.expectEqual('i', l.data);
            try testing.expectEqual(null, l.left);
            try testing.expectEqual(null, l.right);
        } else {
            try testing.expectEqual(false, true); // o.left should not be null
        }
        if (o.right) |r| {
            try testing.expectEqual('x', r.data);
            if (r.left) |rl| {
                try testing.expectEqual('f', rl.data);
                try testing.expectEqual(null, rl.left);
                try testing.expectEqual(null, rl.right);
            } else {
                try testing.expectEqual(false, true); // r.left should not be null
            }
            if (r.right) |rr| {
                try testing.expectEqual('r', rr.data);
                try testing.expectEqual(null, rr.left);
                try testing.expectEqual(null, rr.right);
            } else {
                try testing.expectEqual(false, true); // r.right should not be null
            }
        } else {
            try testing.expectEqual(false, true); // o.right should not be null
        }
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "Reject traversals of different length" {
    const preorder = [_]u8{ 'a', 'b' };
    const inorder = [_]u8{ 'b', 'a', 'r' };
    try testing.expectError(TraversalError.DifferentLengths, Tree.initFromTraversals(testing.allocator, &preorder, &inorder));
}

test "Reject inconsistent traversals of same length" {
    const preorder = [_]u8{ 'x', 'y', 'z' };
    const inorder = [_]u8{ 'a', 'b', 'c' };
    try testing.expectError(TraversalError.DifferentItems, Tree.initFromTraversals(testing.allocator, &preorder, &inorder));
}

test "Reject traversals with repeated items" {
    const preorder = [_]u8{ 'a', 'b', 'a' };
    const inorder = [_]u8{ 'b', 'a', 'a' };
    try testing.expectError(TraversalError.NonUniqueItems, Tree.initFromTraversals(testing.allocator, &preorder, &inorder));
}
