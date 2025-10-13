const std = @import("std");
const mem = std.mem;

pub fn slices(comptime slice_length: usize, allocator: mem.Allocator, series: []const u8) mem.Allocator.Error![][slice_length]u8 {
    comptime {
        std.debug.assert(slice_length > 0);
    }

    var array_list = std.ArrayList([slice_length]u8).empty;
    errdefer array_list.deinit(allocator);
    if (slice_length <= series.len) {
        for (slice_length..(series.len + 1)) |i| {
            var slice: [slice_length]u8 = undefined;
            @memcpy(slice[0..], series[(i - slice_length)..i]);
            try array_list.append(allocator, slice);
        }
    }
    return array_list.toOwnedSlice(allocator);
}
