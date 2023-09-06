const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
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

fn fromBase10(
    allocator: mem.Allocator,
    num: u32,
    output_base: u32,
) mem.Allocator.Error![]u32 {
    if (num == 0) {
        var res = [_]u32{0};
        return &res;
    }
    var list = std.ArrayList(u32).init(allocator);
    var n = num;
    while (n > 0) {
        try list.append(n % output_base);
        n /= output_base;
    }
    var result = try list.toOwnedSlice();
    mem.reverse(u32, result);
    return result;
}

pub fn rebase(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || BaseError)![]u32 {
    if (input_base < 2) return BaseError.InvalidInputBase;
    if (output_base < 2) return BaseError.InvalidOutputBase;

    for (digits) |d| {
        if (d >= input_base) return BaseError.InvalidDigit;
    }

    const base10 = toBase10(digits, input_base);
    return fromBase10(allocator, base10, output_base);
}
