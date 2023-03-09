const std = @import("std");
const testing = std.testing;

const resistor_color = @import("resistor_color.zig");
const ColorBand = resistor_color.ColorBand;

test "black" {
    const expected: usize = 0;
    const actual = resistor_color.colorCode(.black);
    try testing.expectEqual(expected, actual);
}

test "white" {
    const expected: usize = 9;
    const actual = resistor_color.colorCode(.white);
    try testing.expectEqual(expected, actual);
}

test "orange" {
    const expected: usize = 3;
    const actual = resistor_color.colorCode(.orange);
    try testing.expectEqual(expected, actual);
}

test "colors" {
    const expected = &[_]ColorBand{
        .black, .brown, .red,    .orange, .yellow,
        .green, .blue,  .violet, .grey,   .white,
    };
    const actual = resistor_color.colors();
    try testing.expectEqualSlices(ColorBand, expected, actual);
}
