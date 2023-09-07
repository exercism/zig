const std = @import("std");
const mem = std.mem;
const StringMap = std.StringHashMap(void);

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !StringMap {
    _ = allocator;
    _ = word;
    _ = candidates;
    @compileError("please implement the detectAnagrams function");
}
