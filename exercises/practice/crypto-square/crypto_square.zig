const std = @import("std");
const mem = std.mem;

/// Encodes `plaintext` using the square code. Caller owns the returned memory.
pub fn ciphertext(allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = plaintext;
    @compileError("please implement the ciphertext function");
}
