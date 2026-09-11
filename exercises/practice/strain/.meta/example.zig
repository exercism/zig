const std = @import("std");
const mem = std.mem;

/// Returns the items of `list` for which `predicate` is true, in order.
/// Caller owns the returned memory.
pub fn keep(
    comptime T: type,
    allocator: mem.Allocator,
    list: []const T,
    comptime predicate: fn (T) bool,
) mem.Allocator.Error![]T {
    const buffer = try allocator.alloc(T, list.len);
    errdefer allocator.free(buffer);

    var index: usize = 0;
    for (list) |item| {
        if (predicate(item)) {
            buffer[index] = item;
            index += 1;
        }
    }
    return try allocator.realloc(buffer, index);
}

/// Returns the items of `list` for which `predicate` is false, in order.
/// Caller owns the returned memory.
pub fn discard(
    comptime T: type,
    allocator: mem.Allocator,
    list: []const T,
    comptime predicate: fn (T) bool,
) mem.Allocator.Error![]T {
    const negated = struct {
        fn negated(item: T) bool {
            return !predicate(item);
        }
    }.negated;
    return keep(T, allocator, list, negated);
}
