const std = @import("std");
const testing = std.testing;

const proverb = @import("proverb.zig");

fn free(slices: [][]u8) void {
    for (slices) |s| {
        testing.allocator.free(s);
    }
    testing.allocator.free(slices); // No problem when `slices` has zero length.
}

fn reciteTest(allocator: std.mem.Allocator, input: []const []const u8, expected: []const []const u8) anyerror!void {
    const actual = try proverb.recite(allocator, input);
    defer free(actual);

    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "zero pieces" {
    const input = [_][]const u8{};
    const expected = [_][]const u8{};

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}

test "one piece" {
    const input = [_][]const u8{
        "nail",
    };

    const expected = [_][]const u8{
        "And all for the want of a nail.\n",
    };

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}

test "two pieces" {
    const input = [_][]const u8{
        "nail",
        "shoe",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "And all for the want of a nail.\n",
    };

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}

test "three pieces" {
    const input = [_][]const u8{
        "nail",
        "shoe",
        "horse",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "For want of a shoe the horse was lost.\n",
        "And all for the want of a nail.\n",
    };

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}

test "full proverb" {
    const input = [_][]const u8{
        "nail",
        "shoe",
        "horse",
        "rider",
        "message",
        "battle",
        "kingdom",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "For want of a shoe the horse was lost.\n",
        "For want of a horse the rider was lost.\n",
        "For want of a rider the message was lost.\n",
        "For want of a message the battle was lost.\n",
        "For want of a battle the kingdom was lost.\n",
        "And all for the want of a nail.\n",
    };

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}

test "four pieces modernized" {
    const input = [_][]const u8{
        "pin",
        "gun",
        "soldier",
        "battle",
    };

    const expected = [_][]const u8{
        "For want of a pin the gun was lost.\n",
        "For want of a gun the soldier was lost.\n",
        "For want of a soldier the battle was lost.\n",
        "And all for the want of a pin.\n",
    };

    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        reciteTest,
        .{ &input, &expected },
    );
}
