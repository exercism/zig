const std = @import("std");
const mem = std.mem;

/// Encodes `msg` using the rail fence cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8 {
    return cipher(allocator, msg, rails, false);
}

/// Decodes `msg` using the rail fence cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8 {
    return cipher(allocator, msg, rails, true);
}

fn cipher(allocator: mem.Allocator, msg: []const u8, rails: u3, decipher: bool) mem.Allocator.Error![]u8 {
    var table: [8]usize = undefined;
    @memset(&table, 0);
    var rail: i4 = 0;
    var direction: i4 = 1;
    for (0..msg.len) |_| {
        table[@intCast(rail)] += 1;
        rail += direction;
        if (rail == 0 or rail + 1 == rails) {
            direction = -direction;
        }
    }

    var total: usize = 0;
    for (0..rails) |r| {
        const entry = table[r];
        table[r] = total;
        total += entry;
    }

    var result = try allocator.alloc(u8, msg.len);
    rail = 0;
    direction = 1;
    for (0..msg.len) |index| {
        const entry = table[@as(usize, @intCast(rail))];
        if (decipher) {
            result[index] = msg[entry];
        } else {
            result[entry] = msg[index];
        }
        table[@intCast(rail)] += 1;
        rail += direction;
        if (rail == 0 or rail + 1 == rails) {
            direction = -direction;
        }
    }
    return result;
}
