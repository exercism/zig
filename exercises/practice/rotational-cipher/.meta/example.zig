const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var result = try allocator.alloc(u8, text.len);
    for (text, 0..) |ch, i| {
        var letter = (ch | 32) -% 'a';
        if (letter < 26) {
            letter += shiftKey;
            if (letter >= 26) {
                letter -= 26;
            }
            result[i] = (letter + 'A') | (ch & 32);
        } else {
            result[i] = ch;
        }
    }
    return result;
}
