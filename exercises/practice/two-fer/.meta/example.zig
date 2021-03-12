const std = @import("std");
const fmt = std.fmt;

pub fn two_fer(buffer: []u8, name: ?[]const u8) anyerror![]u8 {
    var word = if (name == null) "me" else name;
    var slice = try fmt.bufPrint(buffer, "One for {}, one for you.", .{word});
    return slice;
}
