const std = @import("std");
const testing = std.testing;

const two_fer = @import("two_fer.zig");

const buffer_size = 100;

test "no name given" {
    var response: [buffer_size]u8 = undefined;
    const expected = "One for me, one for you.";
    const actual = try two_fer.twoFer(&response, null);
    try testing.expectEqualStrings(expected, actual);
}

test "a name given" {
    var response: [buffer_size]u8 = undefined;
    const expected = "One for Alice, one for you.";
    const actual = try two_fer.twoFer(&response, "Alice");
    try testing.expectEqualStrings(expected, actual);
}

test "another name given" {
    var response: [buffer_size]u8 = undefined;
    const expected = "One for Bob, one for you.";
    const actual = try two_fer.twoFer(&response, "Bob");
    try testing.expectEqualStrings(expected, actual);
}
