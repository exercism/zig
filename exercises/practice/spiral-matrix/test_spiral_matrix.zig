const std = @import("std");
const testing = std.testing;

const spiral_matrix = @import("spiral_matrix.zig");
const spiral = spiral_matrix.spiral;

fn free(slices: [][]u16) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn spiralTest(allocator: std.mem.Allocator, size: u16, expected: [][]const u16) anyerror!void {
    const actual = try spiral(allocator, size);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u16, expected_slice, actual_slice);
    }
}

test "empty spiral" {
    const expected: [0][]const u16 = undefined;
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 0, &expected },
    );
}

test "trivial spiral" {
    var expected: [1][]const u16 = undefined;
    expected[0] = &.{1};
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 1, &expected },
    );
}

test "spiral of size 2" {
    var expected: [2][]const u16 = undefined;
    expected[0] = &.{ 1, 2 };
    expected[1] = &.{ 4, 3 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 2, &expected },
    );
}

test "spiral of size 3" {
    var expected: [3][]const u16 = undefined;
    expected[0] = &.{ 1, 2, 3 };
    expected[1] = &.{ 8, 9, 4 };
    expected[2] = &.{ 7, 6, 5 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 3, &expected },
    );
}

test "spiral of size 4" {
    var expected: [4][]const u16 = undefined;
    expected[0] = &.{ 1, 2, 3, 4 };
    expected[1] = &.{ 12, 13, 14, 5 };
    expected[2] = &.{ 11, 16, 15, 6 };
    expected[3] = &.{ 10, 9, 8, 7 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 4, &expected },
    );
}

test "spiral of size 5" {
    var expected: [5][]const u16 = undefined;
    expected[0] = &.{ 1, 2, 3, 4, 5 };
    expected[1] = &.{ 16, 17, 18, 19, 6 };
    expected[2] = &.{ 15, 24, 25, 20, 7 };
    expected[3] = &.{ 14, 23, 22, 21, 8 };
    expected[4] = &.{ 13, 12, 11, 10, 9 };
    try testing.checkAllAllocationFailures(
        testing.allocator,
        spiralTest,
        .{ 5, &expected },
    );
}
