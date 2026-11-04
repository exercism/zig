const std = @import("std");
const testing = std.testing;

const satellite = @import("satellite.zig");
const Tree = satellite.Tree;
const Node = satellite.Node;
const Result = (std.mem.Allocator.Error || satellite.TraversalError)!Tree;

fn expectEqualChars(expected: u8, actual: u8) !void {
    const fmtChar = std.zig.fmtChar;
    if (actual != expected) {
        testing.failPrint("expected '{f}', found '{f}'\n", .{
            fmtChar(expected),
            fmtChar(actual),
        });
        return error.TestExpectedEqual;
    }
}

fn expectNull(actual: ?*Node) !void {
    const fmtChar = std.zig.fmtChar;
    if (actual) |a| {
        testing.failPrint("expected null, found node '{f}'\n", .{
            fmtChar(a.data),
        });
        return error.TestExpectedNull;
    }
}

test "Empty tree" {
    const preorder: []const u8 = "";
    const inorder: []const u8 = "";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try expectNull(actual.root);
}

test "Tree with one item" {
    const preorder: []const u8 = "a";
    const inorder: []const u8 = "a";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try testing.expect(actual.root != null);
    try expectEqualChars('a', actual.root.?.data);
    try expectNull(actual.root.?.left);
    try expectNull(actual.root.?.right);
}

test "Tree with many items" {
    const preorder: []const u8 = "aixfr";
    const inorder: []const u8 = "iafxr";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try testing.expect(actual.root != null);
    try expectEqualChars('a', actual.root.?.data);
    try testing.expect(actual.root.?.left != null);
    try expectEqualChars('i', actual.root.?.left.?.data);
    try expectNull(actual.root.?.left.?.left);
    try expectNull(actual.root.?.left.?.right);
    try testing.expect(actual.root.?.right != null);
    try expectEqualChars('x', actual.root.?.right.?.data);
    try testing.expect(actual.root.?.right.?.left != null);
    try expectEqualChars('f', actual.root.?.right.?.left.?.data);
    try expectNull(actual.root.?.right.?.left.?.left);
    try expectNull(actual.root.?.right.?.left.?.right);
    try testing.expect(actual.root.?.right.?.right != null);
    try expectEqualChars('r', actual.root.?.right.?.right.?.data);
    try expectNull(actual.root.?.right.?.right.?.left);
    try expectNull(actual.root.?.right.?.right.?.right);
}

test "Reject traversals of different length" {
    const preorder: []const u8 = "ab";
    const inorder: []const u8 = "bar";
    var actual: Result = .initFromTraversals(
        testing.allocator,
        preorder,
        inorder,
    );
    defer if (actual) |*a| a.deinit() else |_| {};
    try testing.expectError(error.DifferentLengths, actual);
}

test "Reject inconsistent traversals of same length" {
    const preorder: []const u8 = "xyz";
    const inorder: []const u8 = "abc";
    var actual: Result = .initFromTraversals(
        testing.allocator,
        preorder,
        inorder,
    );
    defer if (actual) |*a| a.deinit() else |_| {};
    try testing.expectError(error.DifferentItems, actual);
}

test "Reject traversals with repeated items" {
    const preorder: []const u8 = "aba";
    const inorder: []const u8 = "baa";
    var actual: Result = .initFromTraversals(
        testing.allocator,
        preorder,
        inorder,
    );
    defer if (actual) |*a| a.deinit() else |_| {};
    try testing.expectError(error.NonUniqueItems, actual);
}

test "A degenerate binary tree" {
    const preorder: []const u8 = "abcd";
    const inorder: []const u8 = "dcba";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try testing.expect(actual.root != null);
    try expectEqualChars('a', actual.root.?.data);
    try testing.expect(actual.root.?.left != null);
    try expectEqualChars('b', actual.root.?.left.?.data);
    try testing.expect(actual.root.?.left.?.left != null);
    try expectEqualChars('c', actual.root.?.left.?.left.?.data);
    try testing.expect(actual.root.?.left.?.left.?.left != null);
    try expectEqualChars('d', actual.root.?.left.?.left.?.left.?.data);
    try expectNull(actual.root.?.left.?.left.?.left.?.left);
    try expectNull(actual.root.?.left.?.left.?.left.?.right);
    try expectNull(actual.root.?.left.?.left.?.right);
    try expectNull(actual.root.?.left.?.right);
    try expectNull(actual.root.?.right);
}

test "Another degenerate binary tree" {
    const preorder: []const u8 = "abcd";
    const inorder: []const u8 = "abcd";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try testing.expect(actual.root != null);
    try expectEqualChars('a', actual.root.?.data);
    try expectNull(actual.root.?.left);
    try testing.expect(actual.root.?.right != null);
    try expectEqualChars('b', actual.root.?.right.?.data);
    try expectNull(actual.root.?.right.?.left);
    try testing.expect(actual.root.?.right.?.right != null);
    try expectEqualChars('c', actual.root.?.right.?.right.?.data);
    try expectNull(actual.root.?.right.?.right.?.left);
    try testing.expect(actual.root.?.right.?.right.?.right != null);
    try expectEqualChars('d', actual.root.?.right.?.right.?.right.?.data);
    try expectNull(actual.root.?.right.?.right.?.right.?.left);
    try expectNull(actual.root.?.right.?.right.?.right.?.right);
}

test "Tree with many more items" {
    const preorder: []const u8 = "abdghcefi";
    const inorder: []const u8 = "gdhbaecif";
    var actual: Tree = try .initFromTraversals(testing.allocator, preorder, inorder);
    defer actual.deinit();
    try testing.expect(actual.root != null);
    try expectEqualChars('a', actual.root.?.data);
    try testing.expect(actual.root.?.left != null);
    try expectEqualChars('b', actual.root.?.left.?.data);
    try testing.expect(actual.root.?.left.?.left != null);
    try expectEqualChars('d', actual.root.?.left.?.left.?.data);
    try testing.expect(actual.root.?.left.?.left.?.left != null);
    try expectEqualChars('g', actual.root.?.left.?.left.?.left.?.data);
    try expectNull(actual.root.?.left.?.left.?.left.?.left);
    try expectNull(actual.root.?.left.?.left.?.left.?.right);
    try testing.expect(actual.root.?.left.?.left.?.right != null);
    try expectEqualChars('h', actual.root.?.left.?.left.?.right.?.data);
    try expectNull(actual.root.?.left.?.left.?.right.?.left);
    try expectNull(actual.root.?.left.?.left.?.right.?.right);
    try expectNull(actual.root.?.left.?.right);
    try testing.expect(actual.root.?.right != null);
    try expectEqualChars('c', actual.root.?.right.?.data);
    try testing.expect(actual.root.?.right.?.left != null);
    try expectEqualChars('e', actual.root.?.right.?.left.?.data);
    try expectNull(actual.root.?.right.?.left.?.left);
    try expectNull(actual.root.?.right.?.left.?.right);
    try testing.expect(actual.root.?.right.?.right != null);
    try expectEqualChars('f', actual.root.?.right.?.right.?.data);
    try testing.expect(actual.root.?.right.?.right.?.left != null);
    try expectEqualChars('i', actual.root.?.right.?.right.?.left.?.data);
    try expectNull(actual.root.?.right.?.right.?.left.?.left);
    try expectNull(actual.root.?.right.?.right.?.left.?.right);
    try expectNull(actual.root.?.right.?.right.?.right);
}
