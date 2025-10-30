const std = @import("std");
const testing = std.testing;

const binary_search_tree = @import("binary_search_tree.zig");
const Tree = binary_search_tree.Tree;

fn sortedDataTest(allocator: std.mem.Allocator, tree_data: []const i32, expected: []const i32) anyerror!void {
    var tree = Tree.init(allocator);
    defer tree.deinit();
    for (tree_data) |data| {
        try tree.insert(data);
    }

    const actual = try tree.sortedData(allocator);
    defer allocator.free(actual);
    try testing.expectEqualSlices(i32, expected, actual);
}

test "data is retained" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        try testing.expectEqual(null, o.left);
        try testing.expectEqual(null, o.right);
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "insert data at proper node-smaller number at left node" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    try tree.insert(2);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        if (o.left) |l| {
            try testing.expectEqual(2, l.data);
            try testing.expectEqual(null, l.left);
            try testing.expectEqual(null, l.right);
        } else {
            try testing.expectEqual(false, true); // o.left should not be null
        }
        try testing.expectEqual(null, o.right);
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "insert data at proper node-same number at left node" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    try tree.insert(4);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        if (o.left) |l| {
            try testing.expectEqual(4, l.data);
            try testing.expectEqual(null, l.left);
            try testing.expectEqual(null, l.right);
        } else {
            try testing.expectEqual(false, true); // o.left should not be null
        }
        try testing.expectEqual(null, o.right);
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "insert data at proper node-greater number at right node" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    try tree.insert(5);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        try testing.expectEqual(null, o.left);
        if (o.right) |r| {
            try testing.expectEqual(5, r.data);
            try testing.expectEqual(null, r.left);
            try testing.expectEqual(null, r.right);
        } else {
            try testing.expectEqual(false, true); // o.right should not be null
        }
    } else {
        try testing.expectEqual(false, true); // tree.root should not be null
    }
}

test "can create complex tree" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    try tree.insert(2);
    try tree.insert(6);
    try tree.insert(1);
    try tree.insert(3);
    try tree.insert(5);
    try tree.insert(7);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        if (o.left) |l| {
            try testing.expectEqual(2, l.data);
            if (l.left) |ll| {
                try testing.expectEqual(1, ll.data);
                try testing.expectEqual(null, ll.left);
                try testing.expectEqual(null, ll.right);
            } else {
                try testing.expectEqual(false, true); // l.left should not be null
            }
            if (l.right) |lr| {
                try testing.expectEqual(3, lr.data);
                try testing.expectEqual(null, lr.left);
                try testing.expectEqual(null, lr.right);
            } else {
                try testing.expectEqual(false, true); // l.right should not be null
            }
        } else {
            try testing.expectEqual(false, true); // o.left should not be null
        }
        if (o.right) |r| {
            try testing.expectEqual(6, r.data);
            if (r.left) |rl| {
                try testing.expectEqual(5, rl.data);
                try testing.expectEqual(null, rl.left);
                try testing.expectEqual(null, rl.right);
            } else {
                try testing.expectEqual(false, true); // r.left should not be null
            }
            if (r.right) |rr| {
                try testing.expectEqual(7, rr.data);
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

test "can sort data-can sort single number" {
    const tree_data = [_]i32{2};
    const expected = [_]i32{2};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}

test "can sort data-can sort if second number is smaller than first" {
    const tree_data = [_]i32{ 2, 1 };
    const expected = [_]i32{ 1, 2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}

test "can sort data-can sort if second number is same as first" {
    const tree_data = [_]i32{ 2, 2 };
    const expected = [_]i32{ 2, 2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}

test "can sort data-can sort if second number is greater than first" {
    const tree_data = [_]i32{ 2, 3 };
    const expected = [_]i32{ 2, 3 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}

test "can sort data-can sort complex tree" {
    const tree_data = [_]i32{ 2, 1, 3, 6, 7, 5 };
    const expected = [_]i32{ 1, 2, 3, 5, 6, 7 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}

test "empty tree has null root" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try testing.expectEqual(null, tree.root);
}

test "can sort data-can sort empty tree" {
    const tree_data = [_]i32{};
    const expected = [_]i32{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        sortedDataTest,
        .{ &tree_data, &expected },
    );
}
