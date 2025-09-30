const std = @import("std");
const mem = std.mem;

pub fn spiral(allocator: mem.Allocator, size: u16) mem.Allocator.Error![][]u16 {
    var i: usize = 0;
    var result = try allocator.alloc([]u16, size);
    errdefer {
        while (i > 0) : (i -= 1) {
            allocator.free(result[i - 1]);
        }
        allocator.free(result);
    }

    while (i < size) : (i += 1) {
        result[i] = try allocator.alloc(u16, size);
    }

    var value: u16 = 1;
    var row: usize = 0;
    var column: usize = 0;
    var side_length: usize = size;
    while (side_length >= 2) {
        side_length -= 1;
        for (0..side_length) |_| {
            result[row][column] = value;
            value += 1;
            column += 1;
        }
        for (0..side_length) |_| {
            result[row][column] = value;
            value += 1;
            row += 1;
        }
        for (0..side_length) |_| {
            result[row][column] = value;
            value += 1;
            column -= 1;
        }
        for (0..side_length) |_| {
            result[row][column] = value;
            value += 1;
            row -= 1;
        }
        row += 1;
        column += 1;
        side_length -= 1;
    }

    if (side_length == 1) {
        result[row][column] = value;
        value += 1;
    }
    std.debug.assert(value == size * size + 1);
    return result;
}
