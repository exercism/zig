const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var main_slice = try allocator.alloc([]u8, words.len);

    if (words.len > 1) {
        var i: usize = 0;
        while (i < words.len - 1) : (i += 1) {
            main_slice[i] = try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{ words[i], words[i + 1] });
        }
    }
    if (words.len > 0) {
        main_slice[main_slice.len - 1] = try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
    }
    return main_slice;
}
