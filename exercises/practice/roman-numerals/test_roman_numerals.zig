const std = @import("std");
const testing = std.testing;

const toRoman = @import("roman_numerals.zig").toRoman;

test "1 is I" {
    const expected = "I";
    const actual = try toRoman(testing.allocator, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
