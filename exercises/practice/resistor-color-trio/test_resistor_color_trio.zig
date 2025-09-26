const std = @import("std");
const testing = std.testing;

const resistor_color_trio = @import("resistor_color_trio.zig");
const ColorBand = resistor_color_trio.ColorBand;

fn labelTest(allocator: std.mem.Allocator, colors: []const ColorBand, expected: []const u8) anyerror!void {
    const actual = try resistor_color_trio.label(allocator, colors);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "Orange and orange and black" {
    const colors = [_]ColorBand{ .orange, .orange, .black };
    const expected: []const u8 = "33 ohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Blue and grey and brown" {
    const colors = [_]ColorBand{ .blue, .grey, .brown };
    const expected: []const u8 = "680 ohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Red and black and red" {
    const colors = [_]ColorBand{ .red, .black, .red };
    const expected: []const u8 = "2 kiloohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Green and brown and orange" {
    const colors = [_]ColorBand{ .green, .brown, .orange };
    const expected: []const u8 = "51 kiloohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Yellow and violet and yellow" {
    const colors = [_]ColorBand{ .yellow, .violet, .yellow };
    const expected: []const u8 = "470 kiloohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Blue and violet and blue" {
    const colors = [_]ColorBand{ .blue, .violet, .blue };
    const expected: []const u8 = "67 megaohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Minimum possible value" {
    const colors = [_]ColorBand{ .black, .black, .black };
    const expected: []const u8 = "0 ohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Maximum possible value" {
    const colors = [_]ColorBand{ .white, .white, .white };
    const expected: []const u8 = "99 gigaohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "First two colors make an invalid octal number" {
    const colors = [_]ColorBand{ .black, .grey, .black };
    const expected: []const u8 = "8 ohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Ignore extra colors" {
    const colors = [_]ColorBand{ .blue, .green, .yellow, .orange };
    const expected: []const u8 = "650 kiloohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Orange and orange and red" {
    const colors = [_]ColorBand{ .orange, .orange, .red };
    const expected: []const u8 = "3.3 kiloohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "Orange and orange and green" {
    const colors = [_]ColorBand{ .orange, .orange, .green };
    const expected: []const u8 = "3.3 megaohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "White and white and violet" {
    const colors = [_]ColorBand{ .white, .white, .violet };
    const expected: []const u8 = "990 megaohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}

test "White and white and grey" {
    const colors = [_]ColorBand{ .white, .white, .grey };
    const expected: []const u8 = "9.9 gigaohms";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        labelTest,
        .{ &colors, expected },
    );
}
