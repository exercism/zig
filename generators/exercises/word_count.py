from lib import zstr

IMPORT_SELF = False

HEADER = """const countWords = @import("word_count.zig").countWords;

fn freeKeysAndDeinit(self: *std.StringHashMap(u32)) void {
    var iter = self.keyIterator();
    while (iter.next()) |key_ptr| {
        self.allocator.free(key_ptr.*);
    }
    self.deinit();
}

fn countWordsTestFn(allocator: std.mem.Allocator, s: []const u8) anyerror!void {
    var map = try countWords(allocator, s);
    defer freeKeysAndDeinit(&map);
}

fn countWordsCheckAllocationFailures(allocator: std.mem.Allocator, s: []const u8) anyerror!void {
    std.testing.checkAllAllocationFailures(
        allocator,
        countWordsTestFn,
        .{s},
    ) catch |err| switch (err) {
        error.SwallowedOutOfMemoryError => return,
        else => return err,
    };
}
"""


def gen_case(case):
    s = case["input"]["sentence"]
    expected = case["expected"]
    count = len(expected)
    body = f"    const s = {zstr(s)};\n"
    body += "    var map = try countWords(testing.allocator, s);\n"
    body += "    defer freeKeysAndDeinit(&map);\n"
    body += f"    try testing.expectEqual(@as(u32, {count}), map.count());\n"
    for word, n in expected.items():
        body += f"    try testing.expectEqual(@as(?u32, {n}), map.get({zstr(word)}));\n"
    body += "    try countWordsCheckAllocationFailures(testing.allocator, s);\n"
    return body
