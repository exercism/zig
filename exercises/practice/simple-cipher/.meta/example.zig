const std = @import("std");
const mem = std.mem;

pub const Cipher = struct {
    key: []const u8,

    /// Initializes a cipher with a copy of the given key.
    pub fn init(allocator: mem.Allocator, key: []const u8) mem.Allocator.Error!Cipher {
        return .{
            .key = try allocator.dupe(u8, key),
        };
    }

    /// Initializes a cipher with a randomly generated key of at least 100
    /// lowercase letters.
    pub fn initRandom(allocator: mem.Allocator, random: std.Random) mem.Allocator.Error!Cipher {
        const key = try allocator.alloc(u8, 100);
        for (key) |*item| {
            item.* = random.intRangeAtMost(u8, 'a', 'z');
        }

        return .{
            .key = key,
        };
    }

    /// Frees the key.
    pub fn deinit(self: *Cipher, allocator: mem.Allocator) void {
        allocator.free(self.key);
    }

    /// Encodes `plaintext`. Caller owns the returned memory.
    pub fn encode(self: Cipher, allocator: mem.Allocator, plaintext: []const u8) mem.Allocator.Error![]u8 {
        return process(self, allocator, plaintext, 1);
    }

    /// Decodes `ciphertext`. Caller owns the returned memory.
    pub fn decode(self: Cipher, allocator: mem.Allocator, ciphertext: []const u8) mem.Allocator.Error![]u8 {
        return process(self, allocator, ciphertext, -1);
    }

    fn process(self: Cipher, allocator: mem.Allocator, plaintext: []const u8, direction: i32) mem.Allocator.Error![]u8 {
        const result = try allocator.alloc(u8, plaintext.len);
        for (plaintext, 0..) |c, i| {
            const shift: i32 = self.key[i % self.key.len] - 'a';
            result[i] = @intCast(@mod(c - 'a' + (shift * direction), 26) + 'a');
        }

        return result;
    }
};
