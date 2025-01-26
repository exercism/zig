const std = @import("std");
const mem = std.mem;

pub fn rows(allocator: mem.Allocator, count: usize) mem.Allocator.Error![][]u128 {
    var result = try allocator.alloc([]u128, count);
    for (0..count) |i| {
        result[i] = try allocator.alloc(u128, i + 1);
        result[i][0] = 1;
        result[i][i] = 1;
        if (i == 0) {
            continue;
        }
        for (1..i) |j| {
            result[i][j] = result[i - 1][j - 1] + result[i - 1][j];
        }
    }
    return result;
}
