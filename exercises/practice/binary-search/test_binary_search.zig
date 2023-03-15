const std = @import("std");
const testing = std.testing;

const binary_search = @import("binary_search.zig");
const binarySearch = binary_search.binarySearch;

test "finds a value in an array with one element" {
    const expected: ?usize = 0;
    const array = [_]i4{6};
    const actual = binarySearch(i4, 6, &array);
    try testing.expectEqual(expected, actual);
}

test "finds a value in the middle of an array" {
    const expected: ?usize = 3;
    const array = [_]u4{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(u4, 6, &array);
    try testing.expectEqual(expected, actual);
}

test "finds a value at the beginning of an array" {
    const expected: ?usize = 0;
    const array = [_]i8{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(i8, 1, &array);
    try testing.expectEqual(expected, actual);
}

test "finds a value at the end of an array" {
    const expected: ?usize = 6;
    const array = [_]u8{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(u8, 11, &array);
    try testing.expectEqual(expected, actual);
}

test "finds a value in an array of odd length" {
    const expected: ?usize = 5;
    const array = [_]i16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634 };
    const actual = binarySearch(i16, 21, &array);
    try testing.expectEqual(expected, actual);
}

test "finds a value in an array of even length" {
    const expected: ?usize = 5;
    const array = [_]u16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377 };
    const actual = binarySearch(u16, 21, &array);
    try testing.expectEqual(expected, actual);
}

test "identifies that a value is not included in the array" {
    const expected: ?usize = null;
    const array = [_]i32{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(i32, 7, &array);
    try testing.expectEqual(expected, actual);
}

test "a value smaller than the array's smallest value is not found" {
    const expected: ?usize = null;
    const array = [_]u32{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(u32, 0, &array);
    try testing.expectEqual(expected, actual);
}

test "a value larger than the array's largest value is not found" {
    const expected: ?usize = null;
    const array = [_]i64{ 1, 3, 4, 6, 8, 9, 11 };
    const actual = binarySearch(i64, 13, &array);
    try testing.expectEqual(expected, actual);
}

test "nothing is found in an empty array" {
    const expected: ?usize = null;
    const array = [_]u64{};
    const actual = binarySearch(u64, 13, &array);
    try testing.expectEqual(expected, actual);
}

test "nothing is found when the left and right bounds cross" {
    const expected: ?usize = null;
    const array = [_]isize{ 1, 2 };
    const actual = binarySearch(isize, 13, &array);
    try testing.expectEqual(expected, actual);
}
