const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

fn free(allocator: mem.Allocator, array_list: *std.ArrayList([]u8)) void {
    for (array_list.items) |item| {
        allocator.free(item);
    }
    array_list.deinit(allocator);
}

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    var array_list = try std.ArrayList([]u8).initCapacity(allocator, words.len);
    errdefer free(allocator, &array_list);
    if (words.len == 0) {
        return array_list.toOwnedSlice(allocator);
    }

    for (0..(words.len - 1)) |i| {
        try array_list.append(allocator, try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{ words[i], words[i + 1] }));
    }
    try array_list.append(allocator, try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]}));
    return array_list.toOwnedSlice(allocator);
}
