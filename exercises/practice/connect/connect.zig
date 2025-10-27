const std = @import("std");
const mem = std.mem;

pub fn winner(allocator: mem.Allocator, board: []const []const u8) mem.Allocator.Error!u8 {
    _ = allocator;
    _ = board;
    @compileError("please implement the winner function");
}
