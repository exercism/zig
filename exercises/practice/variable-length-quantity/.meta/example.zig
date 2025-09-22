const std = @import("std");
const mem = std.mem;

pub const DecodeError = error{
    IncompleteSequence,
};

pub fn encode(allocator: mem.Allocator, integers: []const u32) mem.Allocator.Error![]u8 {
    var count: usize = 0;
    for (integers) |integer| {
        var current = integer;
        count += 1;
        current = current >> 7;
        while (current != 0) {
            count += 1;
            current = current >> 7;
        }
    }

    var buffer = try allocator.alloc(u8, count);
    var index: usize = integers.len;
    while (count > 0) {
        index = index - 1;
        var integer = integers[index];

        count -= 1;
        buffer[count] = @as(u8, @intCast(integer & 0x7f));
        integer = integer >> 7;

        while (integer != 0) {
            count -= 1;
            buffer[count] = @as(u8, @intCast((0x80 | integer) & 0xff));
            integer = integer >> 7;
        }
    }
    std.debug.assert(index == 0);
    return buffer;
}

pub fn decode(allocator: mem.Allocator, integers: []const u8) (mem.Allocator.Error || DecodeError)![]u32 {
    var count: usize = 0;
    var complete = true;
    for (integers) |integer| {
        if ((integer & 0x80) != 0) {
            complete = false;
        } else {
            count += 1;
            complete = true;
        }
    }
    if (!complete) {
        return DecodeError.IncompleteSequence;
    }

    var buffer = try allocator.alloc(u32, count);
    var index: usize = 0;
    var current: u32 = 0;
    for (integers) |integer| {
        current = current | (integer & 0x7f);
        if ((integer & 0x80) != 0) {
            current = current << 7;
        } else {
            buffer[index] = current;
            index += 1;
            current = 0;
        }
    }
    std.debug.assert(index == buffer.len);
    return buffer;
}
