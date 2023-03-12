const std = @import("std");
const testing = std.testing;

const secret_handshake = @import("secret_handshake.zig");

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "wink for 1" {
    const expected = &[_]secret_handshake.Signal{.wink};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "double blink for 10" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{.double_blink};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "close your eyes for 100" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{.close_your_eyes};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 4);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "jump for 1000" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{.jump};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 8);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "combine two actions" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{ .wink, .double_blink };
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reverse two actions" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{ .double_blink, .wink };
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 19);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reversing one action gives the same action" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{.jump};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 24);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reversing no actions still gives no actions" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 16);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "all possible actions" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{ .wink, .double_blink, .close_your_eyes, .jump };
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 15);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reverse all possible actions" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{ .jump, .close_your_eyes, .double_blink, .wink };
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 31);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "do nothing for zero" {
    // Delete or comment out below line to run test
    try skipTest();

    const expected = &[_]secret_handshake.Signal{};
    const actual = try secret_handshake.calculateHandshake(testing.allocator, 0);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}
