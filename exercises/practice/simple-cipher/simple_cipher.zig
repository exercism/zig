const std = @import("std");
const mem = std.mem;

pub const Cipher = struct {
    key: []const u8,

    /// Initializes a cipher with a copy of the given key.
    pub fn init(allocator: mem.Allocator, key: []const u8) mem.Allocator.Error!Cipher {
        _ = allocator;
        _ = key;
        @compileError("please implement the init function");
    }

    /// Initializes a cipher with a randomly generated key of at least 100
    /// lowercase letters.
    pub fn initRandom(allocator: mem.Allocator, random: std.Random) mem.Allocator.Error!Cipher {
        _ = allocator;
        _ = random;
        @compileError("please implement the initRandom function");
    }

    /// Frees the key.
    pub fn deinit(self: *Cipher, allocator: mem.Allocator) void {
        _ = self;
        _ = allocator;
        @compileError("please implement the deinit function");
    }

    /// Encodes `plaintext`. Caller owns the returned memory.
    pub fn encode(self: Cipher, allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
        _ = self;
        _ = allocator;
        _ = plaintext;
        @compileError("please implement the encode function");
    }

    /// Decodes `ciphertext`. Caller owns the returned memory.
    pub fn decode(self: Cipher, allocator: mem.Allocator, ciphertext: []const u8) mem.Allocator.Error![]u8 {
        _ = self;
        _ = allocator;
        _ = ciphertext;
        @compileError("please implement the decode function");
    }
};
