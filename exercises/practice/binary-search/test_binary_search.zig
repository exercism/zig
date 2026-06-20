const std = @import("std");
const testing = std.testing;

const binary_search = @import("binary_search.zig");

fn testBinarySearch(comptime T: type, target: T, items: []const T, expected: ?usize) !void {
    try testing.expectEqual(expected, binary_search.binarySearch(T, target, items));
}

test "finds a value in an array with one element" {
    try testBinarySearch(i4, 6, &[_]i4{6}, 0);
}

test "finds a value in the middle of an array" {
    try testBinarySearch(u4, 6, &[_]u4{ 1, 3, 4, 6, 8, 9, 11 }, 3);
}

test "finds a value at the beginning of an array" {
    try testBinarySearch(i8, 1, &[_]i8{ 1, 3, 4, 6, 8, 9, 11 }, 0);
}

test "finds a value at the end of an array" {
    try testBinarySearch(u8, 11, &[_]u8{ 1, 3, 4, 6, 8, 9, 11 }, 6);
}

test "finds a value in an array of odd length" {
    try testBinarySearch(i16, 144, &[_]i16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634 }, 9);
}

test "finds a value in an array of even length" {
    try testBinarySearch(u16, 21, &[_]u16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377 }, 5);
}

test "identifies that a value is not included in the array" {
    try testBinarySearch(i32, 7, &[_]i32{ 1, 3, 4, 6, 8, 9, 11 }, null);
}

test "a value smaller than the array's smallest value is not found" {
    try testBinarySearch(u32, 0, &[_]u32{ 1, 3, 4, 6, 8, 9, 11 }, null);
}

test "a value larger than the array's largest value is not found" {
    try testBinarySearch(i64, 13, &[_]i64{ 1, 3, 4, 6, 8, 9, 11 }, null);
}

test "nothing is found in an empty array" {
    try testBinarySearch(u64, 13, &[_]u64{}, null);
}

test "nothing is found when the left and right bounds cross" {
    try testBinarySearch(isize, 13, &[_]isize{ 1, 2 }, null);
}
