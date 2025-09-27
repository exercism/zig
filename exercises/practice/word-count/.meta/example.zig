const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;

fn freeKeysAndDeinit(self: *std.StringHashMap(u32)) void {
    var iter = self.keyIterator();
    while (iter.next()) |key_ptr| {
        self.allocator.free(key_ptr.*);
    }
    self.deinit();
}

fn insert(allocator: mem.Allocator, result: *std.StringHashMap(u32), word: []const u8) !void {
    const key = try allocator.dupe(u8, word);
    errdefer allocator.free(key);
    try result.*.put(key, 1);
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var lower = try allocator.alloc(u8, s.len);
    defer allocator.free(lower);
    for (s, 0..) |ch, i| {
        lower[i] = ascii.toLower(ch);
    }
    var result = std.StringHashMap(u32).init(allocator);
    errdefer freeKeysAndDeinit(&result);

    var first: usize = 0;
    outer: while (first < lower.len) {
        while (!ascii.isAlphanumeric(lower[first])) {
            first += 1;
            if (first == lower.len) {
                break :outer;
            }
        }
        var last = first + 1;
        while (last < lower.len and (lower[last] == '\'' or ascii.isAlphanumeric(lower[last]))) {
            last += 1;
        }
        while (lower[last - 1] == '\'') {
            last -= 1;
        }
        const word = lower[first..last];
        if (result.getEntry(word)) |entry| {
            entry.value_ptr.* = entry.value_ptr.* + 1;
        } else {
            try insert(allocator, &result, word);
        }
        first = last + 1;
    }
    return result;
}
