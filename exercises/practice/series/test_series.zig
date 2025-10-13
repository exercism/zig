const std = @import("std");
const testing = std.testing;

const slices = @import("series.zig").slices;

test "slices of one from one" {
    const series = "1";
    const expected = [_][1]u8{
        "1"[0..1].*, //
    };
    const actual = try slices(1, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slices of one from two" {
    const series = "12";
    const expected = [_][1]u8{
        "1"[0..1].*, //
        "2"[0..1].*, //
    };
    const actual = try slices(1, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slices of two" {
    const series = "35";
    const expected = [_][2]u8{
        "35"[0..2].*, //
    };
    const actual = try slices(2, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slices of two overlap" {
    const series = "9142";
    const expected = [_][2]u8{
        "91"[0..2].*, //
        "14"[0..2].*, //
        "42"[0..2].*, //
    };
    const actual = try slices(2, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slices can include duplicates" {
    const series = "777777";
    const expected = [_][3]u8{
        "777"[0..3].*, //
        "777"[0..3].*, //
        "777"[0..3].*, //
        "777"[0..3].*, //
    };
    const actual = try slices(3, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slices of a long series" {
    const series = "918493904243";
    const expected = [_][5]u8{
        "91849"[0..5].*, //
        "18493"[0..5].*, //
        "84939"[0..5].*, //
        "49390"[0..5].*, //
        "93904"[0..5].*, //
        "39042"[0..5].*, //
        "90424"[0..5].*, //
        "04243"[0..5].*, //
    };
    const actual = try slices(5, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slice length is too large" {
    const series = "12345";
    const expected = [_][6]u8{};
    const actual = try slices(6, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}

test "slice length is way too large" {
    const series = "12345";
    const expected = [_][42]u8{};
    const actual = try slices(42, testing.allocator, series);
    defer testing.allocator.free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualStrings(&expected_slice, &actual[i]);
    }
}
