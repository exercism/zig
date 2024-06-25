const std = @import("std");
const testing = std.testing;

const square_root = @import("square_root.zig");

test "root of 1" {
    const expected: usize = 1;
    const actual = square_root.squareRoot(1);
    try testing.expectEqual(expected, actual);
}

test "root of 4" {
    const expected: usize = 2;
    const actual = square_root.squareRoot(4);
    try testing.expectEqual(expected, actual);
}

test "root of 25" {
    const expected: usize = 5;
    const actual = square_root.squareRoot(25);
    try testing.expectEqual(expected, actual);
}

test "root of 81" {
    const expected: usize = 9;
    const actual = square_root.squareRoot(81);
    try testing.expectEqual(expected, actual);
}

test "root of 196" {
    const expected: usize = 14;
    const actual = square_root.squareRoot(196);
    try testing.expectEqual(expected, actual);
}

test "root of 65025" {
    const expected: usize = 255;
    const actual = square_root.squareRoot(65025);
    try testing.expectEqual(expected, actual);
}
