const std = @import("std");
const testing = std.testing;

const line_up = @import("line_up.zig");

fn testFormat(allocator: std.mem.Allocator, expected: []const u8, name: []const u8, number: u10) !void {
    const actual = try line_up.format(allocator, name, number);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "format smallest non-exceptional ordinal numeral 4" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Gianna, you are the 4th customer we serve today. Thank you!", "Gianna", 4 },
    );
}

test "format greatest single digit non-exceptional ordinal numeral 9" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Maarten, you are the 9th customer we serve today. Thank you!", "Maarten", 9 },
    );
}

test "format non-exceptional ordinal numeral 5" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Petronila, you are the 5th customer we serve today. Thank you!", "Petronila", 5 },
    );
}

test "format non-exceptional ordinal numeral 6" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Attakullakulla, you are the 6th customer we serve today. Thank you!", "Attakullakulla", 6 },
    );
}

test "format non-exceptional ordinal numeral 7" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Kate, you are the 7th customer we serve today. Thank you!", "Kate", 7 },
    );
}

test "format non-exceptional ordinal numeral 8" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Maximiliano, you are the 8th customer we serve today. Thank you!", "Maximiliano", 8 },
    );
}

test "format exceptional ordinal numeral 1" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Mary, you are the 1st customer we serve today. Thank you!", "Mary", 1 },
    );
}

test "format exceptional ordinal numeral 2" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Haruto, you are the 2nd customer we serve today. Thank you!", "Haruto", 2 },
    );
}

test "format exceptional ordinal numeral 3" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Henriette, you are the 3rd customer we serve today. Thank you!", "Henriette", 3 },
    );
}

test "format smallest two digit non-exceptional ordinal numeral 10" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Alvarez, you are the 10th customer we serve today. Thank you!", "Alvarez", 10 },
    );
}

test "format non-exceptional ordinal numeral 11" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Jacqueline, you are the 11th customer we serve today. Thank you!", "Jacqueline", 11 },
    );
}

test "format non-exceptional ordinal numeral 12" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Juan, you are the 12th customer we serve today. Thank you!", "Juan", 12 },
    );
}

test "format non-exceptional ordinal numeral 13" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Patricia, you are the 13th customer we serve today. Thank you!", "Patricia", 13 },
    );
}

test "format exceptional ordinal numeral 21" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Washi, you are the 21st customer we serve today. Thank you!", "Washi", 21 },
    );
}

test "format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Ingrid, you are the 22nd customer we serve today. Thank you!", "Ingrid", 22 },
    );
}

test "format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Mario, you are the 33rd customer we serve today. Thank you!", "Mario", 33 },
    );
}

test "format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Quentin, you are the 52nd customer we serve today. Thank you!", "Quentin", 52 },
    );
}

test "format exceptional ordinal numeral 62" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Nayra, you are the 62nd customer we serve today. Thank you!", "Nayra", 62 },
    );
}

test "format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Ugo, you are the 72nd customer we serve today. Thank you!", "Ugo", 72 },
    );
}

test "format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Boris, you are the 91st customer we serve today. Thank you!", "Boris", 91 },
    );
}

test "format exceptional ordinal numeral 100" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "John, you are the 100th customer we serve today. Thank you!", "John", 100 },
    );
}

test "format exceptional ordinal numeral 101" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Zeinab, you are the 101st customer we serve today. Thank you!", "Zeinab", 101 },
    );
}

test "format non-exceptional ordinal numeral 112" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Knud, you are the 112th customer we serve today. Thank you!", "Knud", 112 },
    );
}

test "format exceptional ordinal numeral 123" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Yma, you are the 123rd customer we serve today. Thank you!", "Yma", 123 },
    );
}

test "format large number 972 ending in nd even though it is a multiple of 12" {
    try testing.checkAllAllocationFailures(
        testing.allocator,
        testFormat,
        .{ "Elias, you are the 972nd customer we serve today. Thank you!", "Elias", 972 },
    );
}
