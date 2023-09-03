const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = std.AutoHashMap(u64, void).init(allocator);
    defer multiples.deinit();

    var result: u64 = 0;
    for (factors) |f| {
        if (f != 0) {
            var n: u64 = f;
            while (n < limit) {
                if (!multiples.contains(n)) {
                    try multiples.putNoClobber(n, {});
                    result += n;
                }
                n += f;
            }
        }
    }
    return result;
}
