const std = @import("std");
const mem = std.mem;

fn count(s: []const u8) [26]u4 {
    var result = [_]u4{0} ** 26;
    for (s) |c| {
        switch (c) {
            'A'...'Z' => result[c - 'A'] += 1,
            'a'...'z' => result[c - 'a'] += 1,
            else => continue,
        }
    }
    return result;
}

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) ![][]const u8 {
    var list = std.ArrayList([]const u8).init(allocator);
    const target_count = count(word);
    for (candidates) |cand| {
        const cand_count = count(cand);
        if (mem.eql(u4, &target_count, &cand_count) and !std.ascii.eqlIgnoreCase(word, cand)) {
            try list.append(cand);
        }
    }
    return list.toOwnedSlice();
}
