const std = @import("std");
const mem = std.mem;

/// Returns the case-insensitive counts of English letters in `s`.
/// Caller guarantees that `s` contains at most 15 of a single letter.
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

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var result = std.BufSet.init(allocator);
    errdefer result.deinit();
    const target_count = count(word);

    for (candidates) |cand| {
        const cand_count = count(cand);
        if (mem.eql(u4, &target_count, &cand_count) and !std.ascii.eqlIgnoreCase(word, cand)) {
            try result.insert(cand);
        }
    }

    return result;
}
