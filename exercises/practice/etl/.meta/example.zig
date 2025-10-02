const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var result = std.AutoHashMap(u8, i5).init(allocator);
    var iter = legacy.iterator();
    while (iter.next()) |entry| {
        const points: i5 = entry.key_ptr.*;
        for (entry.value_ptr.*) |letter| {
            try result.put(ascii.toLower(letter), points);
        }
    }
    return result;
}
