const std = @import("std");
const mem = std.mem;

pub const BaseError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

fn toBase10(digits: []const usize, from_base: usize) usize {
    var result: usize = 0;
    var power: usize = 1;
    var i: usize = digits.len;
    while (i > 0) {
        i -= 1;
        const d = digits[i];
        result += d * power;
        power *= from_base;
    }
    return result;
}

fn fromBase10(
    allocator: mem.Allocator,
    num: usize,
    to_base: usize,
) mem.Allocator.Error![]usize {
    if (num == 0) {
        var res = [_]usize{0};
        return &res;
    }
    var list = std.ArrayList(usize).init(allocator);
    var n = num;
    while (n > 0) {
        try list.append(n % to_base);
        n /= to_base;
    }
    var result = try list.toOwnedSlice();
    mem.reverse(usize, result);
    return result;
}

pub fn rebase(
    allocator: mem.Allocator,
    digits: []const usize,
    from_base: usize,
    to_base: usize,
) (mem.Allocator.Error || BaseError)![]usize {
    if (from_base < 2) return BaseError.InvalidInputBase;
    if (to_base < 2) return BaseError.InvalidOutputBase;

    for (digits) |d| {
        if (d >= from_base) return BaseError.InvalidDigit;
    }

    const base10 = toBase10(digits, from_base);
    return fromBase10(allocator, base10, to_base);
}
