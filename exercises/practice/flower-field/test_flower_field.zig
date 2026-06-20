const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const flower_field = @import("flower_field.zig");
fn annotateTest(
    allocator: mem.Allocator,
    expected: []const []const u8,
    garden: []const []const u8,
) anyerror!void {
    const actual = try flower_field.annotate(allocator, garden);
    defer {
        for (actual) |line| allocator.free(line);
        allocator.free(actual);
    }
    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |e, a| {
        try testing.expectEqualStrings(e, a);
    }
}

test "no rows" {
    const garden = [_][]const u8{};
    const expected = [_][]const u8{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "no columns" {
    const garden = [_][]const u8{
        "", //
    };
    const expected = [_][]const u8{
        "", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "no flowers" {
    const garden = [_][]const u8{
        "   ", //
        "   ", //
        "   ", //
    };
    const expected = [_][]const u8{
        "   ", //
        "   ", //
        "   ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "garden full of flowers" {
    const garden = [_][]const u8{
        "***", //
        "***", //
        "***", //
    };
    const expected = [_][]const u8{
        "***", //
        "***", //
        "***", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "flower surrounded by spaces" {
    const garden = [_][]const u8{
        "   ", //
        " * ", //
        "   ", //
    };
    const expected = [_][]const u8{
        "111", //
        "1*1", //
        "111", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "space surrounded by flowers" {
    const garden = [_][]const u8{
        "***", //
        "* *", //
        "***", //
    };
    const expected = [_][]const u8{
        "***", //
        "*8*", //
        "***", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "horizontal line" {
    const garden = [_][]const u8{
        " * * ", //
    };
    const expected = [_][]const u8{
        "1*2*1", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "horizontal line, flowers at edges" {
    const garden = [_][]const u8{
        "*   *", //
    };
    const expected = [_][]const u8{
        "*1 1*", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "vertical line" {
    const garden = [_][]const u8{
        " ", //
        "*", //
        " ", //
        "*", //
        " ", //
    };
    const expected = [_][]const u8{
        "1", //
        "*", //
        "2", //
        "*", //
        "1", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "vertical line, flowers at edges" {
    const garden = [_][]const u8{
        "*", //
        " ", //
        " ", //
        " ", //
        "*", //
    };
    const expected = [_][]const u8{
        "*", //
        "1", //
        " ", //
        "1", //
        "*", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "cross" {
    const garden = [_][]const u8{
        "  *  ", //
        "  *  ", //
        "*****", //
        "  *  ", //
        "  *  ", //
    };
    const expected = [_][]const u8{
        " 2*2 ", //
        "25*52", //
        "*****", //
        "25*52", //
        " 2*2 ", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "large garden" {
    const garden = [_][]const u8{
        " *  * ", //
        "  *   ", //
        "    * ", //
        "   * *", //
        " *  * ", //
        "      ", //
    };
    const expected = [_][]const u8{
        "1*22*1", //
        "12*322", //
        " 123*2", //
        "112*4*", //
        "1*22*2", //
        "111111", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}

test "multiple adjacent flowers" {
    const garden = [_][]const u8{
        " ** ", //
    };
    const expected = [_][]const u8{
        "1**1", //
    };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        annotateTest,
        .{ &expected, &garden },
    );
}
