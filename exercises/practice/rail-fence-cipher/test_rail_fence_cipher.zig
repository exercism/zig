const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const rail_fence_cipher = @import("rail_fence_cipher.zig");
const encode = rail_fence_cipher.encode;
const decode = rail_fence_cipher.decode;

const CipherFunc = *const fn (allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8;

fn railFenceCipherTest(allocator: mem.Allocator, cipherFunc: CipherFunc, msg: []const u8, rails: u3, expected: []const u8) anyerror!void {
    const actual = try cipherFunc(allocator, msg, rails);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode with two rails" {
    const phrase: []const u8 = "XOXOXOXOXOXOXOXOXO";
    const expect: []const u8 = "XXXXXXXXXOOOOOOOOO";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &encode, phrase, 2, expect },
    );
}

test "encode with three rails" {
    const phrase: []const u8 = "WEAREDISCOVEREDFLEEATONCE";
    const expect: []const u8 = "WECRLTEERDSOEEFEAOCAIVDEN";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &encode, phrase, 3, expect },
    );
}

test "encode with ending in the middle" {
    const phrase: []const u8 = "EXERCISES";
    const expect: []const u8 = "ESXIEECSR";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &encode, phrase, 4, expect },
    );
}

test "decode with three rails" {
    const phrase: []const u8 = "TEITELHDVLSNHDTISEIIEA";
    const expect: []const u8 = "THEDEVILISINTHEDETAILS";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &decode, phrase, 3, expect },
    );
}

test "decode with five rails" {
    const phrase: []const u8 = "EIEXMSMESAORIWSCE";
    const expect: []const u8 = "EXERCISMISAWESOME";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &decode, phrase, 5, expect },
    );
}

test "decode with six rails" {
    const phrase: []const u8 = "133714114238148966225439541018335470986172518171757571896261";
    const expect: []const u8 = "112358132134558914423337761098715972584418167651094617711286";
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        railFenceCipherTest,
        .{ &decode, phrase, 6, expect },
    );
}
