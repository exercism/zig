const std = @import("std");
const ascii = std.ascii;
const assert = std.debug.assert;
const mem = std.mem;

/// Encodes `plaintext` using the square code. Caller owns the returned memory.
pub fn ciphertext(allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
    var length: usize = 0;
    for (plaintext) |ch| {
        if (ascii.isAlphanumeric(ch)) {
            length += 1;
        }
    }

    // square root of length, rounded up
    var columns: usize = 0;
    while (columns * columns < length) {
        columns += 1;
    }

    var rows: usize = 0;
    if (length != 0) {
        rows = (length + columns - 1) / columns;
        assert(rows * columns >= length);

        // include spaces
        length = (rows + 1) * columns - 1;
    }

    var result = try allocator.alloc(u8, length);

    for (0 .. length) |index| {
        result[index] = ' ';
    }

    var index: usize = 0;
    for (plaintext) |ch| {
        if (!ascii.isAlphanumeric(ch)) {
            continue;
        }
        result[(index % columns) * (rows + 1) + (index / columns)] = ascii.toLower(ch);
        index += 1;
    }

    return result;
}
