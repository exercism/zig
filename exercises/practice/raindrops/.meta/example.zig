const std = @import("std");

pub fn convert(buffer: []u8, comptime n: u32) []const u8 {
    const pling = if (n % 3 == 0) "Pling" else "";
    const plang = if (n % 5 == 0) "Plang" else "";
    const plong = if (n % 7 == 0) "Plong" else "";
    const result = pling ++ plang ++ plong;
    return if (result.len > 0) result else std.fmt.bufPrint(buffer, "{}", .{n}) catch unreachable;
}
