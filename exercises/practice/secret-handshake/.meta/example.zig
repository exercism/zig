const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
    reverse,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var list = std.ArrayList(Signal).init(allocator);
    errdefer list.deinit();
    inline for (comptime std.enums.values(Signal)) |signal| {
        if (1 << @intFromEnum(signal) & number > 0) {
            if (signal == .reverse) mem.reverse(Signal, list.items) else try list.append(signal);
        }
    }
    return list.toOwnedSlice();
}
