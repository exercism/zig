const std = @import("std");
const testing = std.testing;

const two_fer = @import("two_fer.zig");

const buffer_size = 100;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "no name given" {
    var response: [buffer_size]u8 = undefined;
    const expected = "One for you, one for me.";
    const actual = try two_fer.twoFer(&response, null);
    try testing.expectEqualStrings(expected, actual);
}

test "a name given" {
    // Delete or comment out below line to run test
    try skipTest();

    var response: [buffer_size]u8 = undefined;
    const expected = "One for Alice, one for me.";
    const actual = try two_fer.twoFer(&response, "Alice");
    try testing.expectEqualStrings(expected, actual);
}

test "another name given" {
    // Delete or comment out below line to run test
    try skipTest();

    var response: [buffer_size]u8 = undefined;
    const expected = "One for Bob, one for me.";
    const actual = try two_fer.twoFer(&response, "Bob");
    try testing.expectEqualStrings(expected, actual);
}
