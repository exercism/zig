const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var list = std.array_list.Managed(u64).init(allocator);
    errdefer list.deinit();
    var number = value;
    var p: u64 = 2;

    while (number > 1) {
        if (p * p > number) {
            p = number;
        }

        if (number % p == 0) {
            try list.append(p);
            number /= p;
        } else {
            p += 1;
        }
    }

    return list.toOwnedSlice();
}
