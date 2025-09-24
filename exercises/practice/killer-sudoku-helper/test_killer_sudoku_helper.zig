const std = @import("std");
const testing = std.testing;

const killer_sudoku_helper = @import("killer_sudoku_helper.zig");

test "Trivial 1-digit cages-1" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b1};
    const actual = killer_sudoku_helper.combinations(&buffer, 1, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-2" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b10};
    const actual = killer_sudoku_helper.combinations(&buffer, 2, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-3" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b100};
    const actual = killer_sudoku_helper.combinations(&buffer, 3, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-4" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b1000};
    const actual = killer_sudoku_helper.combinations(&buffer, 4, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-5" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b10000};
    const actual = killer_sudoku_helper.combinations(&buffer, 5, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-6" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b100000};
    const actual = killer_sudoku_helper.combinations(&buffer, 6, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-7" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b1000000};
    const actual = killer_sudoku_helper.combinations(&buffer, 7, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-8" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b10000000};
    const actual = killer_sudoku_helper.combinations(&buffer, 8, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Trivial 1-digit cages-9" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b100000000};
    const actual = killer_sudoku_helper.combinations(&buffer, 9, 1, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Cage with sum 45 contains all digits 1:9" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b111111111};
    const actual = killer_sudoku_helper.combinations(&buffer, 45, 9, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Cage with only 1 possible combination" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{0b1011};
    const actual = killer_sudoku_helper.combinations(&buffer, 7, 3, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Cage with several combinations" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{ 0b101000, 0b1000100, 0b10000010, 0b100000001 };
    const actual = killer_sudoku_helper.combinations(&buffer, 10, 2, 0b0);
    try testing.expectEqualSlices(u9, &expected, actual);
}

test "Cage with several combinations that is restricted" {
    const buffer_size = 200;
    var buffer: [buffer_size]u9 = undefined;
    const expected = [_]u9{ 0b1000100, 0b10000010 };
    const actual = killer_sudoku_helper.combinations(&buffer, 10, 2, 0b1001);
    try testing.expectEqualSlices(u9, &expected, actual);
}
