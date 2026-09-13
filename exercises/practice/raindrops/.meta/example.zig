const std = @import("std");

fn append(buffer: []u8, len: usize, sound: []const u8) usize {
    @memcpy(buffer[len..][0..sound.len], sound);
    return len + sound.len;
}

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var len: usize = 0;
    if (n % 3 == 0) len = append(buffer, len, "Pling");
    if (n % 5 == 0) len = append(buffer, len, "Plang");
    if (n % 7 == 0) len = append(buffer, len, "Plong");
    if (len == 0) return std.fmt.bufPrint(buffer, "{d}", .{n}) catch unreachable;
    return buffer[0..len];
}
