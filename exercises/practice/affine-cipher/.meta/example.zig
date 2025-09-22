const std = @import("std");
const mem = std.mem;

pub const AffineCipherError = error{
    NotCoprime,
};

/// Encodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) (mem.Allocator.Error || AffineCipherError)![]u8 {
    _ = try inverse(26, a);
    return process(allocator, phrase, a, b, 5);
}

/// Decodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) (mem.Allocator.Error || AffineCipherError)![]u8 {
    const inv = try inverse(26, a);
    return process(allocator, phrase, inv, @as(u32, (26 - inv) * b), std.math.maxInt(usize));
}

fn inverse(a: u32, b: u32) AffineCipherError!u32 {
    var t: i32 = 0;
    var u: i32 = 1;
    var c = a;
    var d = b;

    while (d != 0) {
        const v: i32 = t - @as(i32, @intCast(c / d)) * u;
        t = u;
        u = v;

        const e: u32 = c % d;
        c = d;
        d = e;
    }

    if (c != 1) {
        return AffineCipherError.NotCoprime;
    }

    if (t < 0) {
        t += @as(i32, @intCast(a));
    }

    return @as(u32, @intCast(t));
}

pub fn process(allocator: mem.Allocator, phrase: []const u8, a: u32, b: u32, group: usize) mem.Allocator.Error![]u8 {
    var count: usize = 0;
    for (phrase) |ch| {
        const digit: u8 = ch -% '0';
        const letter: u8 = (ch | 32) -% 'a';
        if ((digit < 10) or (letter < 26)) {
            count += 1;
        }
    }

    if (count == 0) {
        return "";
    }

    var index: usize = 0;
    var remaining: usize = group;
    var buffer = try allocator.alloc(u8, count + (count - 1) / group);
    for (phrase) |ch| {
        const digit = ch -% '0';
        const letter = (ch | 32) -% 'a';
        var encoded: u8 = ch;
        if (letter < 26) {
            encoded = @as(u8, @intCast((letter * a + b) % 26 + 'a'));
        } else if (digit >= 10) {
            continue;
        }

        if (remaining == 0) {
            buffer[index] = ' ';
            index += 1;
            remaining = group;
        }

        buffer[index] = encoded;
        index += 1;
        remaining -= 1;
    }
    std.debug.assert(index == buffer.len);
    return buffer;
}
