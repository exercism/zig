const std = @import("std");
const testing = std.testing;

const resistor_color = @import("resistor_color.zig");
const ColorBand = resistor_color.ColorBand;

test "test black" {
    const expected = 0;
    const actual = comptime resistor_color.colorCode(.black);
    comptime try testing.expectEqual(expected, actual);
}

test "test white" {
    const expected = 9;
    const actual = comptime resistor_color.colorCode(.white);
    comptime try testing.expectEqual(expected, actual);
}

test "test orange" {
    const expected = 3;
    const actual = comptime resistor_color.colorCode(.orange);
    comptime try testing.expectEqual(expected, actual);
}

test "test colors" {
    const expected = &[_]ColorBand{
        .black, .brown, .red, .orange, .yellow,
        .green, .blue, .violet, .grey, .white,
    };
    const actual = comptime resistor_color.colors();
    comptime try testing.expectEqualSlices(ColorBand, expected, actual);
}
