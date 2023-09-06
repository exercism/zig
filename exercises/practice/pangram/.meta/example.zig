const std = @import("std");
const ascii = std.ascii;

pub fn isPangram(str: []const u8) bool {
    if (str.len < 26) {
        return false;
    }
    var ascii_bit_set: u32 = 0;
    for (str) |c| {
        if (ascii.isASCII(c) and ascii.isAlphabetic(c)) {
            ascii_bit_set |= @as(u32, 1) <<
                @as(u5, @truncate(ascii.toLower(c) - 'a'));
        }
    }
    return ascii_bit_set == 0x03ffffff;
}
