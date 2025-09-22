const std = @import("std");
const mem = std.mem;

pub const AffineCipherError = error{
    NotCoprime,
};

/// Encodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) (mem.Allocator.Error || AffineCipherError)![]u8 {
    _ = allocator;
    _ = phrase;
    _ = a;
    _ = b;
    @compileError("please implement the encode function");
}

/// Decodes `phrase` using the affine cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, phrase: []const u8, a: u8, b: u8) (mem.Allocator.Error || AffineCipherError)![]u8 {
    _ = allocator;
    _ = phrase;
    _ = a;
    _ = b;
    @compileError("please implement the decode function");
}
