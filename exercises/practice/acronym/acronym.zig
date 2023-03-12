const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = words;
    @compileError("please implement the abbreviate function");
}
