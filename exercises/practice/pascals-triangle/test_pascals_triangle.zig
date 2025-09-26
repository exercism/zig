const std = @import("std");
const testing = std.testing;

const pascals_triangle = @import("pascals_triangle.zig");

fn free(slices: [][]u128) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn rowsTest(allocator: std.mem.Allocator, count: usize, expected: [][]const u128) anyerror!void {
    const actual = try pascals_triangle.rows(allocator, count);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "zero rows" {
    const expected: [0][]const u128 = undefined;
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 0, &expected },
    );
}

test "single row" {
    var expected: [1][]const u128 = undefined;
    expected[0] = &.{1};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 1, &expected },
    );
}

test "two rows" {
    var expected: [2][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 2, &expected },
    );
}

test "three rows" {
    var expected: [3][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 3, &expected },
    );
}

test "four rows" {
    var expected: [4][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 4, &expected },
    );
}

test "five rows" {
    var expected: [5][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    expected[4] = &.{ 1, 4, 6, 4, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 5, &expected },
    );
}

test "six rows" {
    var expected: [6][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    expected[4] = &.{ 1, 4, 6, 4, 1 };
    expected[5] = &.{ 1, 5, 10, 10, 5, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 6, &expected },
    );
}

test "ten rows" {
    var expected: [10][]const u128 = undefined;
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    expected[4] = &.{ 1, 4, 6, 4, 1 };
    expected[5] = &.{ 1, 5, 10, 10, 5, 1 };
    expected[6] = &.{ 1, 6, 15, 20, 15, 6, 1 };
    expected[7] = &.{ 1, 7, 21, 35, 35, 21, 7, 1 };
    expected[8] = &.{ 1, 8, 28, 56, 70, 56, 28, 8, 1 };
    expected[9] = &.{ 1, 9, 36, 84, 126, 126, 84, 36, 9, 1 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        rowsTest,
        .{ 10, &expected },
    );
}

test "seventy-five rows" {
    const actual = try pascals_triangle.rows(testing.allocator, 75);
    defer free(actual);

    try testing.expectEqual(17_46_130_564_335_626_209_832, actual[74][37]);
}
