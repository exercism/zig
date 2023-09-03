const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u32 {
    var intset = std.AutoHashMap(u32, void).init(allocator);
    defer intset.deinit();

    var result: u32 = 0;
    for (factors) |f| {
        if (f != 0) {
            var n = f;
            while (n < limit) {
                if (!intset.contains(n)) result += n;
                try intset.put(n, {});
                n += f;
            }
        }
    }
    return result;
}
