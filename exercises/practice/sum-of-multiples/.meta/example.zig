const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) mem.Allocator.Error!u64 {
    var multiples = std.AutoHashMap(u64, void).init(allocator);
    defer multiples.deinit();

    var result: u64 = 0;
    for (factors) |f| {
        if (f != 0) {
            var m: u64 = f;
            while (m < limit) {
                if (!multiples.contains(m)) {
                    try multiples.putNoClobber(m, {});
                    result += m;
                }
                m += f;
            }
        }
    }
    return result;
}
