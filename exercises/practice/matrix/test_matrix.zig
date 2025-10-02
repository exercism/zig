const std = @import("std");
const testing = std.testing;

const matrix = @import("matrix.zig");
const row = matrix.row;
const column = matrix.column;

test "extract row from one number matrix" {
    const expected = &[_]i16{1};
    const s = "1";
    const actual = try row(testing.allocator, s, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "can extract row" {
    const expected = &[_]i16{ 3, 4 };
    const s = "1 2\n3 4";
    const actual = try row(testing.allocator, s, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "extract row where numbers have different widths" {
    const expected = &[_]i16{ 10, 20 };
    const s = "1 2\n10 20";
    const actual = try row(testing.allocator, s, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "can extract row from non-square matrix with no corresponding column" {
    const expected = &[_]i16{ 8, 7, 6 };
    const s = "1 2 3\n4 5 6\n7 8 9\n8 7 6";
    const actual = try row(testing.allocator, s, 4);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "extract column from one number matrix" {
    const expected = &[_]i16{1};
    const s = "1";
    const actual = try column(testing.allocator, s, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "can extract column" {
    const expected = &[_]i16{ 3, 6, 9 };
    const s = "1 2 3\n4 5 6\n7 8 9";
    const actual = try column(testing.allocator, s, 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "can extract column from non-square matrix with no corresponding row" {
    const expected = &[_]i16{ 4, 8, 6 };
    const s = "1 2 3 4\n5 6 7 8\n9 8 7 6";
    const actual = try column(testing.allocator, s, 4);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "extract column where numbers have different widths" {
    const expected = &[_]i16{ 1903, 3, 4 };
    const s = "89 1903 3\n18 3 1\n9 4 800";
    const actual = try column(testing.allocator, s, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "row with negative numbers" {
    const expected = &[_]i16{ -57, 9, -42 };
    const s = "1 2 4\n-57 9 -42\n10 0 65";
    const actual = try row(testing.allocator, s, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}

test "column with negative numbers" {
    const expected = &[_]i16{ -4, -42, -465 };
    const s = "1 2 -4\n-57 9 -42\n10 0 -465";
    const actual = try column(testing.allocator, s, 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(i16, expected, actual);
}
