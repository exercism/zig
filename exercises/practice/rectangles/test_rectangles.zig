const std = @import("std");
const testing = std.testing;

const rectangles = @import("rectangles.zig");

test "no rows" {
    const strings = [_][]const u8{};
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(0, count);
}

test "no columns" {
    const strings = [_][]const u8{
        "", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(0, count);
}

test "no rectangles" {
    const strings = [_][]const u8{
        " ", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(0, count);
}

test "one rectangle" {
    const strings = [_][]const u8{
        "+-+", //
        "| |", //
        "+-+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(1, count);
}

test "two rectangles without shared parts" {
    const strings = [_][]const u8{
        "  +-+", //
        "  | |", //
        "+-+-+", //
        "| |  ", //
        "+-+  ", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(2, count);
}

test "five rectangles with shared parts" {
    const strings = [_][]const u8{
        "  +-+", //
        "  | |", //
        "+-+-+", //
        "| | |", //
        "+-+-+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(5, count);
}

test "rectangle of height 1 is counted" {
    const strings = [_][]const u8{
        "+--+", //
        "+--+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(1, count);
}

test "rectangle of width 1 is counted" {
    const strings = [_][]const u8{
        "++", //
        "||", //
        "++", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(1, count);
}

test "1x1 square is counted" {
    const strings = [_][]const u8{
        "++", //
        "++", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(1, count);
}

test "only complete rectangles are counted" {
    const strings = [_][]const u8{
        "  +-+", //
        "    |", //
        "+-+-+", //
        "| | -", //
        "+-+-+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(1, count);
}

test "rectangles can be of different sizes" {
    const strings = [_][]const u8{
        "+------+----+", //
        "|      |    |", //
        "+---+--+    |", //
        "|   |       |", //
        "+---+-------+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(3, count);
}

test "corner is required for a rectangle to be complete" {
    const strings = [_][]const u8{
        "+------+----+", //
        "|      |    |", //
        "+------+    |", //
        "|   |       |", //
        "+---+-------+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(2, count);
}

test "large input with many rectangles" {
    const strings = [_][]const u8{
        "+---+--+----+", //
        "|   +--+----+", //
        "+---+--+    |", //
        "|   +--+----+", //
        "+---+--+--+-+", //
        "+---+--+--+-+", //
        "+------+  | |", //
        "          +-+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(60, count);
}

test "rectangles must have four sides" {
    const strings = [_][]const u8{
        "+-+ +-+", //
        "| | | |", //
        "+-+-+-+", //
        "  | |  ", //
        "+-+-+-+", //
        "| | | |", //
        "+-+ +-+", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(5, count);
}

test "very large input" {
    const strings = [_][]const u8{
        "      +-----+--------+    +-----+ ", //
        "++---++-----+--------+---++-----++", //
        "||+--++-----+-+-++   |   ||     ||", //
        "|||  ||     +-+-++-+ |   ||     ||", //
        "|||  ||     | | || | |   ||     ||", //
        "||| +++-----+-+-++-+-+---++-+   ||", //
        "||| |||     | | || | |+--++-+-+ ||", //
        "||| +++---+-+-+-++-+-++--++-+ | ||", //
        "||| |||+--+-+-+-+| | |+--++---+ ||", //
        "||| ||||  | | | || | |+-+||     ||", //
        "||+-++++--+-+++-++-+-++-+++---++||", //
        "||  |+++--+-+++-+--+-+| |||   ||||", //
        "+++-+++++---++--+-++-++-+++---+|||", //
        " |+-+++++---++--+ || || |||   ||||", //
        " |  +++++---++--+-++-++-++++  ||||", //
        " |   ||||   |+----++-++-++++--+++|", //
        " |   |+++---+|    || || ||    || |", //
        "+++  |||+---++----+| || ||    || |", //
        "|||  +++----++----++-++-++----++-+", //
        "+++---++----++-----+-++-++----++  ", //
        "                      +-+         ", //
    };
    const count = rectangles.rectangles(&strings);
    try testing.expectEqual(2063, count);
}
