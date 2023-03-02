const std = @import("std");
const testing = std.testing;

const binary_search = @import("binary_search.zig");
const binarySearch = binary_search.binarySearch;
const SearchError = binary_search.SearchError;

test "finds a value in an array with one element" {
    const actual = comptime try binarySearch(i4, 6, &[_]i4{6});
    try testing.expectEqual(0, actual);
}

test "finds a value in the middle of an array" {
    const actual = comptime try binarySearch(u4, 6, &[_]u4{ 1, 3, 4, 6, 8, 9, 11 });
    try testing.expectEqual(3, actual);
}

test "finds a value at the beginning of an array" {
    const actual = comptime try binarySearch(i8, 1, &[_]i8{ 1, 3, 4, 6, 8, 9, 11 });
    try testing.expectEqual(0, actual);
}

test "finds a value at the end of an array" {
    const actual = comptime try binarySearch(u8, 11, &[_]u8{ 1, 3, 4, 6, 8, 9, 11 });
    try testing.expectEqual(6, actual);
}

test "finds a value in an array of odd length" {
    const actual = comptime try binarySearch(i16, 21, &[_]i16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634 });
    try testing.expectEqual(5, actual);
}

test "finds a value in an array of even length" {
    const actual = comptime try binarySearch(u16, 21, &[_]u16{ 1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377 });
    try testing.expectEqual(5, actual);
}

test "identifies that a value is not included in the array" {
    try testing.expectError(SearchError.ValueAbsent, binarySearch(i32, 7, &[_]i32{ 1, 3, 4, 6, 8, 9, 11 }));
}

test "a value smaller than the arrays smallest value is not found" {
    try testing.expectError(SearchError.ValueAbsent, binarySearch(u32, 0, &[_]u32{ 1, 3, 4, 6, 8, 9, 11 }));
}

test "a value larger than the arrays largest value is not found" {
    try testing.expectError(SearchError.ValueAbsent, binarySearch(i64, 13, &[_]i64{ 1, 3, 4, 6, 8, 9, 11 }));
}

test "nothing is found in an empty array" {
    try testing.expectError(SearchError.EmptyBuffer, binarySearch(u64, 13, &[_]u64{}));
}

test "nothing is found when the left and right bounds cross" {
    try testing.expectError(SearchError.ValueAbsent, binarySearch(isize, 13, &[_]isize{ 1, 2 }));
}
