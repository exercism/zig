const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u2) {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var list = std.ArrayList(Signal).init(allocator);
    errdefer list.deinit();
    if (isFlipped(number, 0b1)) {
        try list.append(Signal.wink);
    }
    if (isFlipped(number, 0b10)) {
        try list.append(Signal.double_blink);
    }
    if (isFlipped(number, 0b100)) {
        try list.append(Signal.close_your_eyes);
    }
    if (isFlipped(number, 0b1000)) {
        try list.append(Signal.jump);
    }
    if (isFlipped(number, 0b10000)) {
        mem.reverse(Signal, list.items);
    }
    return list.toOwnedSlice();
}

inline fn isFlipped(number: u5, bit_mask: u5) bool {
    return (number & bit_mask) > 0;
}
