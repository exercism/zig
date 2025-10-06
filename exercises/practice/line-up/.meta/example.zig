const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const suffix = numberSuffix(number);
    return try fmt.allocPrint(allocator, "{s}, you are the {d}{s} customer we serve today. Thank you!", .{ name, number, suffix });
}

fn numberSuffix(number: u10) []const u8 {
    const last_two = number % 100;
    if (last_two % 10 == 1 and last_two != 11) {
        return "st";
    }
    if (last_two % 10 == 2 and last_two != 12) {
        return "nd";
    }
    if (last_two % 10 == 3 and last_two != 13) {
        return "rd";
    }
    return "th";
}
