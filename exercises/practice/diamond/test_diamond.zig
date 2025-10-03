const std = @import("std");
const testing = std.testing;

const rows = @import("diamond.zig").rows;

fn free(slices: [][]u8) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn testRows(allocator: std.mem.Allocator, expected: []const []const u8, letter: u8) !void {
    const actual = try rows(allocator, letter);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (0..expected.len) |i| {
        try testing.expectEqualStrings(expected[i], actual[i]);
    }
}

test "Degenerate case with a single 'A' row" {
    const expected = [_][]const u8{
        "A", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testRows,
        .{ &expected, 'A' },
    );
}

test "Degenerate case with no row containing 3 distinct groups of spaces" {
    const expected = [_][]const u8{
        " A ", //
        "B B", //
        " A ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testRows,
        .{ &expected, 'B' },
    );
}

test "Smallest non-degenerate case with odd diamond side length" {
    const expected = [_][]const u8{
        "  A  ", //
        " B B ", //
        "C   C", //
        " B B ", //
        "  A  ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testRows,
        .{ &expected, 'C' },
    );
}

test "Smallest non-degenerate case with even diamond side length" {
    const expected = [_][]const u8{
        "   A   ", //
        "  B B  ", //
        " C   C ", //
        "D     D", //
        " C   C ", //
        "  B B  ", //
        "   A   ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testRows,
        .{ &expected, 'D' },
    );
}

test "Largest possible diamond" {
    const expected = [_][]const u8{
        "                         A                         ", //
        "                        B B                        ", //
        "                       C   C                       ", //
        "                      D     D                      ", //
        "                     E       E                     ", //
        "                    F         F                    ", //
        "                   G           G                   ", //
        "                  H             H                  ", //
        "                 I               I                 ", //
        "                J                 J                ", //
        "               K                   K               ", //
        "              L                     L              ", //
        "             M                       M             ", //
        "            N                         N            ", //
        "           O                           O           ", //
        "          P                             P          ", //
        "         Q                               Q         ", //
        "        R                                 R        ", //
        "       S                                   S       ", //
        "      T                                     T      ", //
        "     U                                       U     ", //
        "    V                                         V    ", //
        "   W                                           W   ", //
        "  X                                             X  ", //
        " Y                                               Y ", //
        "Z                                                 Z", //
        " Y                                               Y ", //
        "  X                                             X  ", //
        "   W                                           W   ", //
        "    V                                         V    ", //
        "     U                                       U     ", //
        "      T                                     T      ", //
        "       S                                   S       ", //
        "        R                                 R        ", //
        "         Q                               Q         ", //
        "          P                             P          ", //
        "           O                           O           ", //
        "            N                         N            ", //
        "             M                       M             ", //
        "              L                     L              ", //
        "               K                   K               ", //
        "                J                 J                ", //
        "                 I               I                 ", //
        "                  H             H                  ", //
        "                   G           G                   ", //
        "                    F         F                    ", //
        "                     E       E                     ", //
        "                      D     D                      ", //
        "                       C   C                       ", //
        "                        B B                        ", //
        "                         A                         ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        testRows,
        .{ &expected, 'Z' },
    );
}
