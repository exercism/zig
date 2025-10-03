const std = @import("std");
const mem = std.mem;

/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return select(allocator, s, index, 0);
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    return select(allocator, s, 0, index);
}

pub fn select(allocator: mem.Allocator, s: []const u8, required_row: i32, required_column: i32) ![]i16 {
    var list = std.array_list.Managed(i16).init(allocator);
    errdefer list.deinit();
    var current_row: i32 = 1;
    var current_column: i32 = 1;
    var number: i16 = 0;
    var negate: bool = false;

    for (0.., s) |i, c| {
        switch (c) {
            '0'...'9' => {
                number = 10 * number + (c - '0');
                if (i + 1 == s.len or s[i + 1] < '0') {
                    if (negate) {
                        number = -number;
                        negate = false;
                    }
                    if (current_row == required_row or current_column == required_column) {
                        try list.append(number);
                    }
                    number = 0;
                }
            },
            ' ' => {
                current_column += 1;
            },
            '\n' => {
                current_row += 1;
                current_column = 1;
            },
            '-' => {
                negate = true;
            },
            else => unreachable,
        }
    }
    return list.toOwnedSlice();
}
