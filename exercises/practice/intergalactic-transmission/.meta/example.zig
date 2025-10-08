const std = @import("std");
const mem = std.mem;

pub const TransmissionError = error{
    WrongParity,
};

fn parity(data: u8) u8 {
    var n = data;
    var result: u8 = 0;
    while (n != 0) {
        n -= n & (~n + 1);
        result = 1 - result;
    }
    return result;
}

fn transmit(list: *std.array_list.Managed(u8), pending: u16) mem.Allocator.Error!void {
    const data = @as(u8, @intCast(pending & 0x7f));
    try list.append((data << 1) | parity(data));
}

pub fn transmitSequence(allocator: mem.Allocator, message: []const u8) mem.Allocator.Error![]u8 {
    var list = std.array_list.Managed(u8).init(allocator);
    defer list.deinit();
    var count: u4 = 0;
    var pending: u16 = 0;
    for (0.., message) |i, byte| {
        pending = (pending << 8) | byte;
        count += 1;
        try transmit(&list, pending >> count);

        if (i + 1 == message.len) {
            pending <<= (7 - count);
            count = 7;
        }
        if (count == 7) {
            try transmit(&list, pending);
            count = 0;
        }
        std.debug.assert(count < 7);
    }
    std.debug.assert(count == 0);
    return try list.toOwnedSlice();
}

pub fn decodeMessage(allocator: mem.Allocator, message: []const u8) (mem.Allocator.Error || TransmissionError)![]u8 {
    var list = std.array_list.Managed(u8).init(allocator);
    defer list.deinit();
    var count: u4 = 0;
    var pending: u16 = 0;
    for (message) |byte| {
        if (parity(byte) != 0) {
            return TransmissionError.WrongParity;
        }
        pending = (pending << 7) | (byte >> 1);
        count += 7;
        if (count >= 8) {
            count -= 8;
            try list.append(@as(u8, @intCast((pending >> count) & 0xff)));
        }
        std.debug.assert(count < 8);
    }
    return try list.toOwnedSlice();
}
