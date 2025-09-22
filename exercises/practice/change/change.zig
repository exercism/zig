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
    _ = allocator;
    _ = coins;
    _ = target;
    @compileError("please implement the findFewestCoins function");
}
