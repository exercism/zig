const std = @import("std");
const math = std.math;
const mem = std.mem;

pub fn prime(allocator: mem.Allocator, number: usize) !usize {
    // The first two primes are 2 and 3.
    if (number <= 2) {
        return number + 1;
    }

    const limit = number * math.log2_int_ceil(usize, number);
    const table = try allocator.alloc(bool, limit);
    defer allocator.free(table);
    @memset(table, false);

    var remaining = number - 2;
    var p: usize = 1;
    var step: usize = 4;
    while (true) {
        p += step; // skip multiples of 2 and multiples of 3
        step = 6 - step;
        if (table[p]) {
            continue;
        }

        remaining -= 1;
        if (remaining == 0) {
            return p;
        }

        var q = p * p;
        while (q < limit) {
            table[q] = true;
            q += 2 * p;
        }
    }
}
