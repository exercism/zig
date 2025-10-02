const std = @import("std");
const testing = std.testing;

const etl = @import("etl.zig");
const transform = etl.transform;

test "single letter" {
    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);
    try legacy.put(1, "A");
    var actual = try transform(testing.allocator, legacy);
    legacy.deinit();

    try testing.expectEqual(1, actual.count());
    try testing.expectEqual(1, actual.get('a'));
    actual.deinit();
}

test "single score with multiple letters" {
    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);
    try legacy.put(1, "AEIOU");
    var actual = try transform(testing.allocator, legacy);
    legacy.deinit();

    try testing.expectEqual(5, actual.count());
    try testing.expectEqual(1, actual.get('a'));
    try testing.expectEqual(1, actual.get('e'));
    try testing.expectEqual(1, actual.get('i'));
    try testing.expectEqual(1, actual.get('o'));
    try testing.expectEqual(1, actual.get('u'));
    actual.deinit();
}

test "multiple scores with multiple letters" {
    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);
    try legacy.put(1, "AE");
    try legacy.put(2, "DG");
    var actual = try transform(testing.allocator, legacy);
    legacy.deinit();

    try testing.expectEqual(4, actual.count());
    try testing.expectEqual(1, actual.get('a'));
    try testing.expectEqual(2, actual.get('d'));
    try testing.expectEqual(1, actual.get('e'));
    try testing.expectEqual(2, actual.get('g'));
    actual.deinit();
}

test "multiple scores with differing numbers of letters" {
    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);
    try legacy.put(1, "AEIOULNRST");
    try legacy.put(10, "QZ");
    try legacy.put(2, "DG");
    try legacy.put(3, "BCMP");
    try legacy.put(4, "FHVWY");
    try legacy.put(5, "K");
    try legacy.put(8, "JX");
    var actual = try transform(testing.allocator, legacy);
    legacy.deinit();

    try testing.expectEqual(26, actual.count());
    try testing.expectEqual(1, actual.get('a'));
    try testing.expectEqual(3, actual.get('b'));
    try testing.expectEqual(3, actual.get('c'));
    try testing.expectEqual(2, actual.get('d'));
    try testing.expectEqual(1, actual.get('e'));
    try testing.expectEqual(4, actual.get('f'));
    try testing.expectEqual(2, actual.get('g'));
    try testing.expectEqual(4, actual.get('h'));
    try testing.expectEqual(1, actual.get('i'));
    try testing.expectEqual(8, actual.get('j'));
    try testing.expectEqual(5, actual.get('k'));
    try testing.expectEqual(1, actual.get('l'));
    try testing.expectEqual(3, actual.get('m'));
    try testing.expectEqual(1, actual.get('n'));
    try testing.expectEqual(1, actual.get('o'));
    try testing.expectEqual(3, actual.get('p'));
    try testing.expectEqual(10, actual.get('q'));
    try testing.expectEqual(1, actual.get('r'));
    try testing.expectEqual(1, actual.get('s'));
    try testing.expectEqual(1, actual.get('t'));
    try testing.expectEqual(1, actual.get('u'));
    try testing.expectEqual(4, actual.get('v'));
    try testing.expectEqual(4, actual.get('w'));
    try testing.expectEqual(8, actual.get('x'));
    try testing.expectEqual(4, actual.get('y'));
    try testing.expectEqual(10, actual.get('z'));
    actual.deinit();
}
