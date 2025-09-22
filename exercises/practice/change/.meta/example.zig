const std = @import("std");
const mem = std.mem;

pub const ChangeError = error{
    NegativeTarget,
    UnreachableTarget,
};

pub fn findFewestCoins(
    allocator: mem.Allocator,
    coins: []const u64,
    target: i64,
) (mem.Allocator.Error || ChangeError)![]u64 {
    if (target < 0) {
        return ChangeError.NegativeTarget;
    }

    var required = @as(u64, @intCast(target));
    var table = try allocator.alloc(u64, required + 1);
    defer allocator.free(table);
    table[0] = 0;

    for (1..table.len) |index| {
        var best: u64 = table.len;
        for (coins) |coin| {
            if (coin <= index and table[index - coin] < best) {
                best = table[index - coin] + 1;
            }
        }
        table[index] = best;
    }

    if (table[required] > required) {
        return ChangeError.UnreachableTarget;
    }

    var result = try allocator.alloc(u64, table[required]);
    var index: usize = 0;
    while (required > 0) {
        for (coins) |coin| {
            if (coin <= required and table[required - coin] == table[required] - 1) {
                required -= coin;
                result[index] = coin;
                index += 1;
                break;
            }
        } else {
            std.debug.assert(false);
        }
    }
    std.debug.assert(index == table[table.len - 1]);
    return result;
}
