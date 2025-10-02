const std = @import("std");
const math = std.math;
const mem = std.mem;

pub const Pair = struct {
    first: u64,
    second: u64,
};

pub const Palindrome = struct {
    value: u64,
    factors: []Pair,
};

fn palindrome(number: u64) bool {
    var buffer: [20]u64 = undefined;
    buffer[0] = number % 10;
    var end: usize = 1;
    var n: u64 = number / 10;
    while (n != 0) {
        buffer[end] = n % 10;
        end += 1;
        n = n / 10;
    }

    var begin: usize = 0;
    while (begin + 1 < end) {
        end -= 1;
        if (buffer[begin] != buffer[end]) {
            return false;
        }
        begin += 1;
    }
    return true;
}

pub fn smallest(allocator: mem.Allocator, min: u64, max: u64) mem.Allocator.Error!?Palindrome {
    std.debug.assert(min <= max);
    var value: u64 = math.maxInt(u64);
    var factors = std.array_list.Managed(Pair).init(allocator);
    errdefer factors.deinit();

    for (min..max) |i| {
        const first = @as(u64, @intCast(i));
        for (first..max) |j| {
            const second = @as(u64, @intCast(j));
            const product = first * second;
            if (product > value) {
                break;
            }

            if (!palindrome(product)) {
                continue;
            }

            if (product < value) {
                factors.clearRetainingCapacity();
                value = product;
            }

            try factors.append(.{ .first = first, .second = second });
        }
    }
    if (factors.items.len == 0) {
        return null;
    }

    return .{
        .value = value,
        .factors = try factors.toOwnedSlice(),
    };
}

pub fn largest(allocator: mem.Allocator, min: u64, max: u64) mem.Allocator.Error!?Palindrome {
    std.debug.assert(min <= max);
    var value: u64 = 0;

    var factors = std.array_list.Managed(Pair).init(allocator);
    errdefer factors.deinit();

    for (0..(max - min + 1)) |i| {
        const second = @as(u64, @intCast(max - i));
        for (0..(second - min + 1)) |j| {
            const first = @as(u64, @intCast(second - j));
            const product = first * second;
            if (product < value) {
                break;
            }

            if (!palindrome(product)) {
                continue;
            }

            if (product > value) {
                factors.clearRetainingCapacity();
                value = product;
            }

            try factors.append(.{ .first = first, .second = second });
        }
    }
    if (factors.items.len == 0) {
        return null;
    }

    return .{
        .value = value,
        .factors = try factors.toOwnedSlice(),
    };
}
