const std = @import("std");
const testing = std.testing;

const transpose = @import("transpose.zig").transpose;

fn free(slices: [][]u8) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn testTranspose(allocator: std.mem.Allocator, expected: []const []const u8, lines: []const []const u8) !void {
    const actual = try transpose(allocator, lines);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (0..expected.len) |i| {
        try testing.expectEqualStrings(expected[i], actual[i]);
    }
}

test "empty string" {
    const lines = [_][]const u8{};
    const expected = [_][]const u8{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "two characters in a row" {
    const lines = [_][]const u8{
        "A1", //
    };
    const expected = [_][]const u8{
        "A", //
        "1", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "two characters in a column" {
    const lines = [_][]const u8{
        "A", //
        "1", //
    };
    const expected = [_][]const u8{
        "A1", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "simple" {
    const lines = [_][]const u8{
        "ABC", //
        "123", //
    };
    const expected = [_][]const u8{
        "A1", //
        "B2", //
        "C3", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "single line" {
    const lines = [_][]const u8{
        "Single line.", //
    };
    const expected = [_][]const u8{
        "S", //
        "i", //
        "n", //
        "g", //
        "l", //
        "e", //
        " ", //
        "l", //
        "i", //
        "n", //
        "e", //
        ".", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "first line longer than second line" {
    const lines = [_][]const u8{
        "The fourth line.", //
        "The fifth line.", //
    };
    const expected = [_][]const u8{
        "TT", //
        "hh", //
        "ee", //
        "  ", //
        "ff", //
        "oi", //
        "uf", //
        "rt", //
        "th", //
        "h ", //
        " l", //
        "li", //
        "in", //
        "ne", //
        "e.", //
        ".", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "second line longer than first line" {
    const lines = [_][]const u8{
        "The first line.", //
        "The second line.", //
    };
    const expected = [_][]const u8{
        "TT", //
        "hh", //
        "ee", //
        "  ", //
        "fs", //
        "ie", //
        "rc", //
        "so", //
        "tn", //
        " d", //
        "l ", //
        "il", //
        "ni", //
        "en", //
        ".e", //
        " .", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "mixed line length" {
    const lines = [_][]const u8{
        "The longest line.", //
        "A long line.", //
        "A longer line.", //
        "A line.", //
    };
    const expected = [_][]const u8{
        "TAAA", //
        "h   ", //
        "elll", //
        " ooi", //
        "lnnn", //
        "ogge", //
        "n e.", //
        "glr", //
        "ei ", //
        "snl", //
        "tei", //
        " .n", //
        "l e", //
        "i .", //
        "n", //
        "e", //
        ".", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "square" {
    const lines = [_][]const u8{
        "HEART", //
        "EMBER", //
        "ABUSE", //
        "RESIN", //
        "TREND", //
    };
    const expected = [_][]const u8{
        "HEART", //
        "EMBER", //
        "ABUSE", //
        "RESIN", //
        "TREND", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "rectangle" {
    const lines = [_][]const u8{
        "FRACTURE", //
        "OUTLINED", //
        "BLOOMING", //
        "SEPTETTE", //
    };
    const expected = [_][]const u8{
        "FOBS", //
        "RULE", //
        "ATOP", //
        "CLOT", //
        "TIME", //
        "UNIT", //
        "RENT", //
        "EDGE", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "triangle" {
    const lines = [_][]const u8{
        "T", //
        "EE", //
        "AAA", //
        "SSSS", //
        "EEEEE", //
        "RRRRRR", //
    };
    const expected = [_][]const u8{
        "TEASER", //
        " EASER", //
        "  ASER", //
        "   SER", //
        "    ER", //
        "     R", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}

test "jagged triangle" {
    const lines = [_][]const u8{
        "11", //
        "2", //
        "3333", //
        "444", //
        "555555", //
        "66666", //
    };
    const expected = [_][]const u8{
        "123456", //
        "1 3456", //
        "  3456", //
        "  3 56", //
        "    56", //
        "    5", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testTranspose,
        .{ &expected, &lines },
    );
}
