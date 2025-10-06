const std = @import("std");
const testing = std.testing;

const line_up = @import("line_up.zig");
const format = line_up.format;

test "format smallest non-exceptional ordinal numeral 4" {
    const expected: []const u8 = "Gianna, you are the 4th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Gianna", 4);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format greatest single digit non-exceptional ordinal numeral 9" {
    const expected: []const u8 = "Maarten, you are the 9th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Maarten", 9);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 5" {
    const expected: []const u8 = "Petronila, you are the 5th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Petronila", 5);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 6" {
    const expected: []const u8 = "Attakullakulla, you are the 6th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Attakullakulla", 6);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 7" {
    const expected: []const u8 = "Kate, you are the 7th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Kate", 7);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 8" {
    const expected: []const u8 = "Maximiliano, you are the 8th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Maximiliano", 8);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 1" {
    const expected: []const u8 = "Mary, you are the 1st customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Mary", 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 2" {
    const expected: []const u8 = "Haruto, you are the 2nd customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Haruto", 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 3" {
    const expected: []const u8 = "Henriette, you are the 3rd customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Henriette", 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format smallest two digit non-exceptional ordinal numeral 10" {
    const expected: []const u8 = "Alvarez, you are the 10th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Alvarez", 10);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 11" {
    const expected: []const u8 = "Jacqueline, you are the 11th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Jacqueline", 11);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 12" {
    const expected: []const u8 = "Juan, you are the 12th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Juan", 12);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 13" {
    const expected: []const u8 = "Patricia, you are the 13th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Patricia", 13);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 21" {
    const expected: []const u8 = "Washi, you are the 21st customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Washi", 21);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 62" {
    const expected: []const u8 = "Nayra, you are the 62nd customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Nayra", 62);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 100" {
    const expected: []const u8 = "John, you are the 100th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "John", 100);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 101" {
    const expected: []const u8 = "Zeinab, you are the 101st customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Zeinab", 101);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format non-exceptional ordinal numeral 112" {
    const expected: []const u8 = "Knud, you are the 112th customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Knud", 112);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format exceptional ordinal numeral 123" {
    const expected: []const u8 = "Yma, you are the 123rd customer we serve today. Thank you!";
    const actual = try format(testing.allocator, "Yma", 123);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
