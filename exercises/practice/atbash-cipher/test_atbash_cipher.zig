const std = @import("std");
const testing = std.testing;

const atbash_cipher = @import("atbash_cipher.zig");
const encode = atbash_cipher.encode;
const decode = atbash_cipher.decode;

test "encode yes" {
    const expected = "bvh";
    const s = "yes";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode no" {
    const expected = "ml";
    const s = "no";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode omg" {
    const expected = "lnt";
    const s = "OMG";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode spaces" {
    const expected = "lnt";
    const s = "O M G";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode mindblowingly" {
    const expected = "nrmwy oldrm tob";
    const s = "mindblowingly";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode numbers" {
    const expected = "gvhgr mt123 gvhgr mt";
    const s = "Testing,1 2 3, testing.";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode deep thought" {
    const expected = "gifgs rhurx grlm";
    const s = "Truth is fiction.";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "encode all the letters" {
    const expected = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt";
    const s = "The quick brown fox jumps over the lazy dog.";
    const actual = try encode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode exercism" {
    const expected = "exercism";
    const s = "vcvix rhn";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode a sentence" {
    const expected = "anobstacleisoftenasteppingstone";
    const s = "zmlyh gzxov rhlug vmzhg vkkrm thglm v";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode numbers" {
    const expected = "testing123testing";
    const s = "gvhgr mt123 gvhgr mt";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode all the letters" {
    const expected = "thequickbrownfoxjumpsoverthelazydog";
    const s = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode with too many spaces" {
    const expected = "exercism";
    const s = "vc vix    r hn";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "decode with no spaces" {
    const expected = "anobstacleisoftenasteppingstone";
    const s = "zmlyhgzxovrhlugvmzhgvkkrmthglmv";
    const actual = try decode(testing.allocator, s);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
