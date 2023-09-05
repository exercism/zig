const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

fn toBase10(digits: []const u32, from_base: u32) u32 {
    var result: u32 = 0;
    var power: u32 = 1;
    var iter = mem.reverseIterator(digits);
    while (iter.next()) |d| {
        result += d * power;
        power *= from_base;
    }
    return result;
}

fn fromBase10(buffer: []u32, num: u32, to_base: u32) []u32 {
    if (num == 0) {
        var res = [_]u32{0};
        return &res;
    }
    var n = num;
    var i: usize = 0;
    while (n > 0) {
        buffer[i] = n % to_base;
        n /= to_base;
        i += 1;
    }
    mem.reverse(u32, buffer);
    return buffer[buffer.len-i..];
}

/// Converts `digits` from `from_base` to `to_base`.
/// Caller guarantees that `buffer` is large enough to store the result.
pub fn rebase(buffer: []u32, digits: []const u32, from_base: u32, to_base: u32) BaseError![]u32 {
    if (from_base < 2) return BaseError.InvalidInputBase;
    if (to_base < 2) return BaseError.InvalidOutputBase;

    for (digits) |d| {
        if (d >= from_base) return BaseError.InvalidDigit;
    }

    const base10 = toBase10(digits, from_base);
    return fromBase10(buffer, base10, to_base);
}
