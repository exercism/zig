const std = @import("std");
const assert = std.debug.assert;
const mem = std.mem;

pub const ColorBand = enum {
    black,
    brown,
    red,
    orange,
    yellow,
    green,
    blue,
    violet,
    grey,
    white,
};

fn colorCode(color: ColorBand) u8 {
    return switch (color) {
        .black => 0,
        .brown => 1,
        .red => 2,
        .orange => 3,
        .yellow => 4,
        .green => 5,
        .blue => 6,
        .violet => 7,
        .grey => 8,
        .white => 9,
    };
}

const units = [_][]const u8{ " ohms", " kiloohms", " megaohms", " gigaohms" };

fn appendString(buffer: []u8, offset: *usize, str: []const u8) void {
    @memcpy(buffer[offset.*..(offset.* + str.len)], str);
    offset.* += str.len;
}

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    assert(colors.len >= 3);
    const first = colorCode(colors[0]) + '0';
    const second = colorCode(colors[1]) + '0';
    const third = colorCode(colors[2]) + 1;

    var buffer: [16]u8 = undefined;
    var offset: usize = 0;
    switch (third % 3) {
        0 => {
            buffer[0] = first;
            if (second == '0') {
                offset = 1;
            } else {
                buffer[1] = '.';
                buffer[2] = second;
                offset = 3;
            }
        },
        1 => {
            if (first == '0') {
                buffer[0] = second;
                offset = 1;
            } else {
                buffer[0] = first;
                buffer[1] = second;
                offset = 2;
            }
        },
        2 => {
            buffer[0] = first;
            buffer[1] = second;
            buffer[2] = '0';
            offset = 3;
        },
        else => unreachable,
    }

    appendString(&buffer, &offset, units[third / 3]);

    const result = try allocator.alloc(u8, offset);
    @memcpy(result, buffer[0..offset]);
    return result;
}
