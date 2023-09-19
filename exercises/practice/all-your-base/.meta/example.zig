const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

fn toBase10(digits: []const u32, input_base: u32) u32 {
    var result: u32 = 0;
    var power: u32 = 1;
    var iter = mem.reverseIterator(digits);
    while (iter.next()) |d| {
        result += d * power;
        power *= input_base;
    }
    return result;
}

fn fromBase10(allocator: mem.Allocator, num: u32, output_base: u32) mem.Allocator.Error![]u32 {
    var list = std.ArrayList(u32).init(allocator);
    errdefer list.deinit();
    var n = num;
    while (n > 0) {
        try list.append(n % output_base);
        n /= output_base;
    }
    if (list.items.len == 0) try list.append(0);
    var result = try list.toOwnedSlice();
    mem.reverse(u32, result);
    return result;
}

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    for (digits) |d| {
        if (d >= input_base) return ConversionError.InvalidDigit;
    }

    const base10 = toBase10(digits, input_base);
    return fromBase10(allocator, base10, output_base);
}
