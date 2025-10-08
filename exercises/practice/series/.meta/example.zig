const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

fn free(allocator: mem.Allocator, array_list: *std.ArrayList([]u8)) void {
    for (array_list.items) |item| {
        allocator.free(item);
    }
    array_list.deinit(allocator);
}

pub fn slices(comptime slice_length: usize, allocator: mem.Allocator, series: []const u8) mem.Allocator.Error![][]u8 {
    comptime {
        std.debug.assert(slice_length > 0);
    }

    var array_list = std.ArrayList([]u8).empty;
    errdefer free(allocator, &array_list);
    if (slice_length <= series.len) {
        for (slice_length..(series.len + 1)) |i| {
            try array_list.append(allocator, try fmt.allocPrint(allocator, "{s}", .{series[(i - slice_length)..i]}));
        }
    }
    return array_list.toOwnedSlice(allocator);
}
