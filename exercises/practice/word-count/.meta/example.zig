const std = @import("std");
const mem = std.mem;
const StringMap = std.StringHashMap(u32);
const Word = std.ArrayList(u8);

/// If `self` contains the key `word`, increments its value by 1.
/// Otherwise, dupes `word` and puts it into `self`, setting its value to 1.
/// Clears `word`.
fn incOrPut(self: *StringMap, word: *Word) mem.Allocator.Error!void {
    const res = try self.getOrPut(word.items);
    if (res.found_existing) {
        res.value_ptr.* += 1;
    } else {
        const dupe = try self.allocator.dupe(u8, word.items);
        errdefer self.allocator.free(dupe);
        res.key_ptr.* = dupe;
        res.value_ptr.* = 1;
    }
    word.clearRetainingCapacity();
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error!StringMap {
    var result = StringMap.init(allocator);
    errdefer result.deinit();

    var word = Word.init(allocator);
    defer word.deinit();

    for (s, 0..) |c, i| {
        switch (c) {
            '0'...'9' => try word.append(c),
            'A'...'Z' => try word.append('a' + c - 'A'),
            'a'...'z' => try word.append(c),
            '\'' => if (word.items.len > 0 and i + 1 < s.len and std.ascii.isAlphabetic(s[i + 1])) {
                try word.append(c);
            },
            else => if (word.items.len > 0) try incOrPut(&result, &word),
        }
    }
    if (word.items.len > 0) try incOrPut(&result, &word);
    return result;
}
