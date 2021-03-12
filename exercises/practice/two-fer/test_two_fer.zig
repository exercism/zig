const std = @import("std");
const testing = std.testing;

const two_fer = @import("two_fer.zig");

const BUFFER_SIZE = 100;

test "no name given" {
    var response: [BUFFER_SIZE]u8 = undefined;
    const expected = "One for me, one for you.";
    const actual = try two_fer.two_fer(&response, null);
    testing.expectEqualStrings(expected, actual);
}

test "a name given" {
    var response: [BUFFER_SIZE]u8 = undefined;
    const expected = "One for Alice, one for you.";
    const actual = try two_fer.two_fer(&response, "Alice");
    testing.expectEqualStrings(expected, actual);
}

test "another name given" {
    var response: [BUFFER_SIZE]u8 = undefined;
    const expected = "One for Bob, one for you.";
    const actual = try two_fer.two_fer(&response, "Bob");
    testing.expectEqualStrings(expected, actual);
}
