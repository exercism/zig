const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
    reverse,
};

pub fn calculateHandshake(allocator: mem.Allocator, n: u5) mem.Allocator.Error![]const Signal {
    const signals = comptime std.enums.values(Signal);
    var list = try std.ArrayList(Signal).initCapacity(allocator, signals.len - 1);
    errdefer list.deinit();
    inline for (signals) |signal| {
        if (1 << @intFromEnum(signal) & n > 0) {
            if (signal == .reverse) {
                mem.reverse(Signal, list.items);
            } else {
                list.appendAssumeCapacity(signal);
            }
        }
    }
    return list.toOwnedSlice();
}
