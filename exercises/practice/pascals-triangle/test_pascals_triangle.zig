const std = @import("std");
const testing = std.testing;

const pascals_triangle = @import("pascals_triangle.zig");

fn free(slices: [][]u128) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

test "zero rows" {
    const expected = try testing.allocator.alloc([]const u128, 0);
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 0);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "single row" {
    var expected = try testing.allocator.alloc([]const u128, 1);
    expected[0] = &.{1};
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 1);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "two rows" {
    var expected = try testing.allocator.alloc([]const u128, 2);
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 2);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "three rows" {
    var expected = try testing.allocator.alloc([]const u128, 3);
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 3);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "four rows" {
    var expected = try testing.allocator.alloc([]const u128, 4);
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 4);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "five rows" {
    var expected = try testing.allocator.alloc([]const u128, 5);
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    expected[4] = &.{ 1, 4, 6, 4, 1 };
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 5);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "six rows" {
    var expected = try testing.allocator.alloc([]const u128, 6);
    expected[0] = &.{1};
    expected[1] = &.{ 1, 1 };
    expected[2] = &.{ 1, 2, 1 };
    expected[3] = &.{ 1, 3, 3, 1 };
    expected[4] = &.{ 1, 4, 6, 4, 1 };
    expected[5] = &.{ 1, 5, 10, 10, 5, 1 };
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 6);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "ten rows" {
    var expected = try testing.allocator.alloc([]const u128, 10);
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
    defer testing.allocator.free(expected);

    const actual = try pascals_triangle.rows(testing.allocator, 10);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}

test "seventy-five rows" {
    const actual = try pascals_triangle.rows(testing.allocator, 75);
    defer free(actual);

    try testing.expectEqual(17_46_130_564_335_626_209_832, actual[74][37]);
}
