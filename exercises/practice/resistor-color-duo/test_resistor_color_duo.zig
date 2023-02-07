const std = @import("std");
const testing = std.testing;

const resistor_color_duo = @import("resistor_color_duo.zig");
const ColorBand = resistor_color_duo.ColorBand;

test "brown and black" {
    const array = [_]ColorBand{.brown, .black};
    const expected = 10;
    const actual = comptime try resistor_color_duo.colorCode(&array);
    try testing.expectEqual(expected, actual);
}

test "blue and grey" {
    const array = [_]ColorBand{.blue, .grey};
    const expected = 68;
    const actual = comptime try resistor_color_duo.colorCode(&array);
    try testing.expectEqual(expected, actual);
}

test "yellow and violet" {
    const array = [_]ColorBand{.yellow, .violet};
    const expected = 47;
    const actual = comptime try resistor_color_duo.colorCode(&array);
    try testing.expectEqual(expected, actual);
}

test "orange and orange" {
    const array = [_]ColorBand{.orange, .orange};
    const expected = 33;
    const actual = comptime try resistor_color_duo.colorCode(&array);
    try testing.expectEqual(expected, actual);
}

test "ignore additional colors" {
    const array = [_]ColorBand{.green, .brown, .orange};
    const expected = 51;
    const actual = comptime try resistor_color_duo.colorCode(&array);
    try testing.expectEqual(expected, actual);
}
