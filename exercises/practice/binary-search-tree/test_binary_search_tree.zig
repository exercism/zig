const std = @import("std");
const testing = std.testing;

const binary_search_tree = @import("binary_search_tree.zig");
const Tree = binary_search_tree.Tree;

test "data is retained" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(4);
    if (tree.root) |o| {
        try testing.expectEqual(4, o.data);
        try testing.expectEqual(null, o.left);
        try testing.expectEqual(null, o.right);
    } else {
        unreachable;
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
            unreachable;
        }
        try testing.expectEqual(null, o.right);
    } else {
        unreachable;
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
            unreachable;
        }
        try testing.expectEqual(null, o.right);
    } else {
        unreachable;
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
            unreachable;
        }
    } else {
        unreachable;
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
                unreachable;
            }
            if (l.right) |lr| {
                try testing.expectEqual(3, lr.data);
                try testing.expectEqual(null, lr.left);
                try testing.expectEqual(null, lr.right);
            } else {
                unreachable;
            }
        } else {
            unreachable;
        }
        if (o.right) |r| {
            try testing.expectEqual(6, r.data);
            if (r.left) |rl| {
                try testing.expectEqual(5, rl.data);
                try testing.expectEqual(null, rl.left);
                try testing.expectEqual(null, rl.right);
            } else {
                unreachable;
            }
            if (r.right) |rr| {
                try testing.expectEqual(7, rr.data);
                try testing.expectEqual(null, rr.left);
                try testing.expectEqual(null, rr.right);
            } else {
                unreachable;
            }
        } else {
            unreachable;
        }
    } else {
        unreachable;
    }
}

test "can sort data-can sort single number" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(2);
    const expected = [_]i32{2};
    const actual = try tree.sortedData();
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i32, &expected, actual);
}

test "can sort data-can sort if second number is smaller than first" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(2);
    try tree.insert(1);
    const expected = [_]i32{ 1, 2 };
    const actual = try tree.sortedData();
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i32, &expected, actual);
}

test "can sort data-can sort if second number is same as first" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(2);
    try tree.insert(2);
    const expected = [_]i32{ 2, 2 };
    const actual = try tree.sortedData();
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i32, &expected, actual);
}

test "can sort data-can sort if second number is greater than first" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(2);
    try tree.insert(3);
    const expected = [_]i32{ 2, 3 };
    const actual = try tree.sortedData();
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i32, &expected, actual);
}

test "can sort data-can sort complex tree" {
    var tree = Tree.init(testing.allocator);
    defer tree.deinit();
    try tree.insert(2);
    try tree.insert(1);
    try tree.insert(3);
    try tree.insert(6);
    try tree.insert(7);
    try tree.insert(5);
    const expected = [_]i32{ 1, 2, 3, 5, 6, 7 };
    const actual = try tree.sortedData();
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i32, &expected, actual);
}
