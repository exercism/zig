const std = @import("std");
const mem = std.mem;

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) ![][]const u8 {
    _ = allocator;
    _ = word;
    _ = candidates;
    @compileError("please implement the detectAnagrams function");
}
