const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u2) {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

pub fn calculateHandshake(
    allocator: mem.Allocator,
    number: isize
) mem.Allocator.Error![]const Signal {
    var list = std.ArrayList(Signal).init(allocator);
    defer list.deinit();
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
    // Reverse the ArrayList's contents.
    if (isFlipped(number, 0b10000) and list.items.len > 1) {
        var i: usize = 0;
        var j: usize = list.items.len - 1;
        while (i < j) : ({ i += 1; j -= 1; }) {
            var temp = list.items[i];
            list.items[i] = list.items[j];
            list.items[j] = temp;
        }
    }
    return list.toOwnedSlice();
}

inline fn isFlipped(number: isize, bit_mask: isize) bool {
    return (number & bit_mask) > 0;
}
