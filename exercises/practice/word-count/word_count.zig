const std = @import("std");
const mem = std.mem;

pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    _ = allocator;
    _ = s;
    @compileError("please implement the countWords function");
}
