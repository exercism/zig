const std = @import("std");
const mem = std.mem;
const StringSet = std.BufSet;

/// Returns the items in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !StringSet {
    _ = allocator;
    _ = word;
    _ = candidates;
    @compileError("please implement the detectAnagrams function");
}
