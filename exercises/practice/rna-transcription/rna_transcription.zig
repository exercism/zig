const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    _ = allocator;
    _ = dna;
    @compileError("please implement the toRna function");
}
