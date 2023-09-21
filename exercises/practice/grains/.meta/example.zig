const std = @import("std");

/// Asserts that `index` is greater than 0 and less than 65.
pub fn square(index: u7) u64 {
    std.debug.assert(index > 0 and index < 65);
    return @as(u64, 1) << @as(u6, @truncate(index - 1));
}

pub fn total() u64 {
    return std.math.maxInt(u64);
}
