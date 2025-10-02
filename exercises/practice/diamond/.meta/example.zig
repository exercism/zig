const std = @import("std");
const mem = std.mem;

fn free(allocator: mem.Allocator, array_list: *std.ArrayList([]u8)) void {
    for (array_list.items) |item| {
        allocator.free(item);
    }
    array_list.deinit(allocator);
}

pub fn rows(allocator: mem.Allocator, letter: u8) mem.Allocator.Error![][]u8 {
    std.debug.assert(letter >= 'A');
    std.debug.assert(letter <= 'Z');
    const mid = letter - 'A';
    const len = 2 * mid + 1;
    var array_list = try std.ArrayList([]u8).initCapacity(allocator, len);
    errdefer free(allocator, &array_list);

    for (0..len) |i| {
        var row = try allocator.alloc(u8, len);
        @memset(row, ' ');
        const j = if (i <= mid) i else (len - 1 - i);
        const ch: u8 = @as(u8, @intCast('A' + j));
        row[mid - j] = ch;
        row[mid + j] = ch;

        array_list.appendAssumeCapacity(row);
    }

    return array_list.toOwnedSlice(allocator);
}
