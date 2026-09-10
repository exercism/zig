const std = @import("std");
const testing = std.testing;

const strain = @import("strain.zig");
const keep = strain.keep;
const discard = strain.discard;

fn alwaysTrue(_: u32) bool {
    return true;
}

fn alwaysFalse(_: u32) bool {
    return false;
}

fn isOdd(x: u32) bool {
    return x % 2 == 1;
}

fn isEven(x: u32) bool {
    return x % 2 == 0;
}

fn startsWithZ(x: []const u8) bool {
    return std.mem.startsWith(u8, x, "z");
}

fn containsFive(x: []const u32) bool {
    return std.mem.indexOfScalar(u32, x, 5) != null;
}

/// Binds an element type and a predicate, providing allocation-checked
/// wrappers around `keep` and `discard`.
fn Case(comptime T: type, comptime predicate: fn (T) bool) type {
    return struct {
        fn expectEqualElements(expected: T, actual: T) !void {
            if (comptime T == []const u8) {
                try testing.expectEqualStrings(expected, actual);
            } else if (comptime T == []const u32) {
                try testing.expectEqualSlices(u32, expected, actual);
            } else {
                try testing.expectEqual(expected, actual);
            }
        }

        fn testKeep(allocator: std.mem.Allocator, list: []const T, expected: []const T) !void {
            const actual = try keep(T, allocator, list, predicate);
            defer allocator.free(actual);
            try testing.expectEqual(expected.len, actual.len);
            for (expected, actual) |e, a| try expectEqualElements(e, a);
        }

        fn testDiscard(allocator: std.mem.Allocator, list: []const T, expected: []const T) !void {
            const actual = try discard(T, allocator, list, predicate);
            defer allocator.free(actual);
            try testing.expectEqual(expected.len, actual.len);
            for (expected, actual) |e, a| try expectEqualElements(e, a);
        }
    };
}

test "keep on empty list returns empty list" {
    const list = [_]u32{};
    const expected = [_]u32{};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysTrue).testKeep,
        .{ &list, &expected },
    );
}

test "keeps everything" {
    const list = [_]u32{ 1, 3, 5 };
    const expected = [_]u32{ 1, 3, 5 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysTrue).testKeep,
        .{ &list, &expected },
    );
}

test "keeps nothing" {
    const list = [_]u32{ 1, 3, 5 };
    const expected = [_]u32{};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysFalse).testKeep,
        .{ &list, &expected },
    );
}

test "keeps first and last" {
    const list = [_]u32{ 1, 2, 3 };
    const expected = [_]u32{ 1, 3 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, isOdd).testKeep,
        .{ &list, &expected },
    );
}

test "keeps neither first nor last" {
    const list = [_]u32{ 1, 2, 3 };
    const expected = [_]u32{2};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, isEven).testKeep,
        .{ &list, &expected },
    );
}

test "keeps strings" {
    const list = [_][]const u8{ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" };
    const expected = [_][]const u8{ "zebra", "zombies", "zealot" };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case([]const u8, startsWithZ).testKeep,
        .{ &list, &expected },
    );
}

test "keeps lists" {
    const list = [_][]const u32{ &.{ 1, 2, 3 }, &.{ 5, 5, 5 }, &.{ 5, 1, 2 }, &.{ 2, 1, 2 }, &.{ 1, 5, 2 }, &.{ 2, 2, 1 }, &.{ 1, 2, 5 } };
    const expected = [_][]const u32{ &.{ 5, 5, 5 }, &.{ 5, 1, 2 }, &.{ 1, 5, 2 }, &.{ 1, 2, 5 } };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case([]const u32, containsFive).testKeep,
        .{ &list, &expected },
    );
}

test "discard on empty list returns empty list" {
    const list = [_]u32{};
    const expected = [_]u32{};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysTrue).testDiscard,
        .{ &list, &expected },
    );
}

test "discards everything" {
    const list = [_]u32{ 1, 3, 5 };
    const expected = [_]u32{};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysTrue).testDiscard,
        .{ &list, &expected },
    );
}

test "discards nothing" {
    const list = [_]u32{ 1, 3, 5 };
    const expected = [_]u32{ 1, 3, 5 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, alwaysFalse).testDiscard,
        .{ &list, &expected },
    );
}

test "discards first and last" {
    const list = [_]u32{ 1, 2, 3 };
    const expected = [_]u32{2};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, isOdd).testDiscard,
        .{ &list, &expected },
    );
}

test "discards neither first nor last" {
    const list = [_]u32{ 1, 2, 3 };
    const expected = [_]u32{ 1, 3 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case(u32, isEven).testDiscard,
        .{ &list, &expected },
    );
}

test "discards strings" {
    const list = [_][]const u8{ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" };
    const expected = [_][]const u8{ "apple", "banana", "cherimoya" };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case([]const u8, startsWithZ).testDiscard,
        .{ &list, &expected },
    );
}

test "discards lists" {
    const list = [_][]const u32{ &.{ 1, 2, 3 }, &.{ 5, 5, 5 }, &.{ 5, 1, 2 }, &.{ 2, 1, 2 }, &.{ 1, 5, 2 }, &.{ 2, 2, 1 }, &.{ 1, 2, 5 } };
    const expected = [_][]const u32{ &.{ 1, 2, 3 }, &.{ 2, 1, 2 }, &.{ 2, 2, 1 } };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        Case([]const u32, containsFive).testDiscard,
        .{ &list, &expected },
    );
}
