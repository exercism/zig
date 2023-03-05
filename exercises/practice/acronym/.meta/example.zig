const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var letters = std.ArrayList(u8).init(allocator);
    defer letters.deinit();

    var i: usize = 0;
    while (i < words.len) : (i += 1) {
        if (!ascii.isAlpha(words[i])) continue;

        if (i == 0 or words[i - 1] == ' ' or words[i - 1] == '-' or words[i - 1] == '_')
            try letters.append(ascii.toUpper(words[i]));
    }

    return letters.toOwnedSlice();
}
