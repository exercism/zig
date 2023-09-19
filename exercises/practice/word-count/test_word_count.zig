const std = @import("std");
const testing = std.testing;

const countWords = @import("word_count.zig").countWords;

fn freeKeysAndDeinit(self: *std.StringHashMap(u32)) void {
    var iter = self.keyIterator();
    while (iter.next()) |key_ptr| {
        self.allocator.free(key_ptr.*);
    }
    self.deinit();
}

test "count one word" {
    const s = "word";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 1), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("word"));
}

test "count one of each word" {
    const s = "one of each";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 3), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("one"));
    try testing.expectEqual(@as(?u32, 1), map.get("of"));
    try testing.expectEqual(@as(?u32, 1), map.get("each"));
}

test "multiple occurrences of a word" {
    const s = "one fish two fish red fish blue fish";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 5), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("one"));
    try testing.expectEqual(@as(?u32, 4), map.get("fish"));
    try testing.expectEqual(@as(?u32, 1), map.get("two"));
    try testing.expectEqual(@as(?u32, 1), map.get("red"));
    try testing.expectEqual(@as(?u32, 1), map.get("blue"));
}

test "handles cramped lists" {
    const s = "one,two,three";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 3), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("one"));
    try testing.expectEqual(@as(?u32, 1), map.get("two"));
    try testing.expectEqual(@as(?u32, 1), map.get("three"));
}

test "handles expanded lists" {
    const s = "one,\ntwo,\nthree";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 3), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("one"));
    try testing.expectEqual(@as(?u32, 1), map.get("two"));
    try testing.expectEqual(@as(?u32, 1), map.get("three"));
}

test "ignore punctuation" {
    const s = "car: carpet as java: javascript!!&@$%^&";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 5), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("car"));
    try testing.expectEqual(@as(?u32, 1), map.get("carpet"));
    try testing.expectEqual(@as(?u32, 1), map.get("as"));
    try testing.expectEqual(@as(?u32, 1), map.get("java"));
    try testing.expectEqual(@as(?u32, 1), map.get("javascript"));
}

test "include numbers" {
    const s = "testing, 1, 2 testing";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 3), map.count());
    try testing.expectEqual(@as(?u32, 2), map.get("testing"));
    try testing.expectEqual(@as(?u32, 1), map.get("1"));
    try testing.expectEqual(@as(?u32, 1), map.get("2"));
}

test "normalize case" {
    const s = "go Go GO Stop stop";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 2), map.count());
    try testing.expectEqual(@as(?u32, 3), map.get("go"));
    try testing.expectEqual(@as(?u32, 2), map.get("stop"));
}

test "with apostrophes" {
    const s = "'First: don't laugh. Then: don't cry. You're getting it.'";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 8), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("first"));
    try testing.expectEqual(@as(?u32, 2), map.get("don't"));
    try testing.expectEqual(@as(?u32, 1), map.get("laugh"));
    try testing.expectEqual(@as(?u32, 1), map.get("then"));
    try testing.expectEqual(@as(?u32, 1), map.get("cry"));
    try testing.expectEqual(@as(?u32, 1), map.get("you're"));
    try testing.expectEqual(@as(?u32, 1), map.get("getting"));
    try testing.expectEqual(@as(?u32, 1), map.get("it"));
}

test "with quotations" {
    const s = "Joe can't tell between 'large' and large.";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 6), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("joe"));
    try testing.expectEqual(@as(?u32, 1), map.get("can't"));
    try testing.expectEqual(@as(?u32, 1), map.get("tell"));
    try testing.expectEqual(@as(?u32, 1), map.get("between"));
    try testing.expectEqual(@as(?u32, 2), map.get("large"));
    try testing.expectEqual(@as(?u32, 1), map.get("and"));
}

test "substrings from the beginning" {
    const s = "Joe can't tell between app, apple and a.";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 8), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("joe"));
    try testing.expectEqual(@as(?u32, 1), map.get("can't"));
    try testing.expectEqual(@as(?u32, 1), map.get("tell"));
    try testing.expectEqual(@as(?u32, 1), map.get("between"));
    try testing.expectEqual(@as(?u32, 1), map.get("app"));
    try testing.expectEqual(@as(?u32, 1), map.get("apple"));
    try testing.expectEqual(@as(?u32, 1), map.get("and"));
    try testing.expectEqual(@as(?u32, 1), map.get("a"));
}

test "multiple spaces not detected as a word" {
    const s = " multiple   whitespaces";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 2), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("multiple"));
    try testing.expectEqual(@as(?u32, 1), map.get("whitespaces"));
}

test "alternating word separators not detected as a word" {
    const s = ",\n,one,\n ,two \n 'three'";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 3), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("one"));
    try testing.expectEqual(@as(?u32, 1), map.get("two"));
    try testing.expectEqual(@as(?u32, 1), map.get("three"));
}

test "quotation for word with apostrophe" {
    const s = "can, can't, 'can't'";
    var map = try countWords(testing.allocator, s);
    defer freeKeysAndDeinit(&map);
    try testing.expectEqual(@as(u32, 2), map.count());
    try testing.expectEqual(@as(?u32, 1), map.get("can"));
    try testing.expectEqual(@as(?u32, 2), map.get("can't"));
}
