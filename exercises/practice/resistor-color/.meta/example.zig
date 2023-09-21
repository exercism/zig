const std = @import("std");

pub const ColorBand = enum(u4) {
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

pub fn colorCode(color: ColorBand) u4 {
    return @intFromEnum(color);
}

pub fn colors() []const ColorBand {
    return std.enums.values(ColorBand);
}
