const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const usize, limit: usize) !usize {
    var intset = std.AutoHashMap(usize, void).init(allocator);
    defer intset.deinit();

    var result: usize = 0;
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
