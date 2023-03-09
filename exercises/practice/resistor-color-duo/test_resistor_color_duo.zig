const std = @import("std");
const testing = std.testing;

const resistor_color_duo = @import("resistor_color_duo.zig");
const ColorBand = resistor_color_duo.ColorBand;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "brown and black" {
    const array = [_]ColorBand{ .brown, .black };
    const expected: usize = 10;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}

test "blue and grey" {
    // Delete or comment out below line to run test
    try skipTest();

    const array = [_]ColorBand{ .blue, .grey };
    const expected: usize = 68;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}

test "yellow and violet" {
    // Delete or comment out below line to run test
    try skipTest();

    const array = [_]ColorBand{ .yellow, .violet };
    const expected: usize = 47;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}

test "white and red" {
    // Delete or comment out below line to run test
    try skipTest();

    const array = [_]ColorBand{ .white, .red };
    const expected: usize = 92;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}

test "orange and orange" {
    // Delete or comment out below line to run test
    try skipTest();

    const array = [_]ColorBand{ .orange, .orange };
    const expected: usize = 33;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}

test "black and brown, one-digit" {
    // Delete or comment out below line to run test
    try skipTest();

    const array = [_]ColorBand{ .black, .brown };
    const expected: usize = 1;
    const actual = resistor_color_duo.colorCode(array);
    try testing.expectEqual(expected, actual);
}
