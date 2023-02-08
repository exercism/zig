const std = @import("std");

pub fn convert(buf: []u8, comptime n: usize) []const u8 {
    const pling = if (n % 3 == 0) "Pling" else "";
    const plang = if (n % 5 == 0) "Plang" else "";
    const plong = if (n % 7 == 0) "Plong" else "";
    const result = pling ++ plang ++ plong;
    if (result.len == 0) return std.fmt.bufPrint(buf, "{}", .{n}) catch unreachable;
    return result;
}
