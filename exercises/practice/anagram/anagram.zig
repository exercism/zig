const std = @import("std");
const mem = std.mem;

pub fn findAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) ![][]const u8 {
    _ = allocator;
    _ = word;
    _ = candidates;
    @compileError("please implement the findAnagrams function");
}
