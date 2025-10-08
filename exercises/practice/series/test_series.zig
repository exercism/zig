const std = @import("std");
const testing = std.testing;

const slices = @import("series.zig").slices;

fn free(arr: [][]u8) void {
    for (arr) |s| {
        testing.allocator.free(s);
    }
    testing.allocator.free(arr);
}

test "slices of one from one" {
    const series = "1";
    const expected = [_][]const u8{"1"};
    const actual = try slices(1, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slices of one from two" {
    const series = "12";
    const expected = [_][]const u8{ "1", "2" };
    const actual = try slices(1, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slices of two" {
    const series = "35";
    const expected = [_][]const u8{"35"};
    const actual = try slices(2, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slices of two overlap" {
    const series = "9142";
    const expected = [_][]const u8{ "91", "14", "42" };
    const actual = try slices(2, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slices can include duplicates" {
    const series = "777777";
    const expected = [_][]const u8{ "777", "777", "777", "777" };
    const actual = try slices(3, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slices of a long series" {
    const series = "918493904243";
    const expected = [_][]const u8{ "91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243" };
    const actual = try slices(5, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slice length is too large" {
    const series = "12345";
    const expected = [_][]const u8{};
    const actual = try slices(6, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}

test "slice length is way too large" {
    const series = "12345";
    const expected = [_][]const u8{};
    const actual = try slices(42, testing.allocator, series);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(expected_slice, actual[i]);
    }
}
