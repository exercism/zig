const std = @import("std");
const fmt = std.fmt;

pub fn twoFer(buffer: []u8, name: ?[]const u8) anyerror![]u8 {
    const word = if (name == null) "you" else name;
    const slice = try fmt.bufPrint(buffer, "One for {?s}, one for me.", .{word});
    return slice;
}
