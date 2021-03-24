const std = @import("std");
const testing = std.testing;

const secret_handshake = @import("secret_handshake.zig");

test "wink for 1" {
    const expected = &[_]secret_handshake.Signal{.wink};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 1);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "double blink for 10" {
    const expected = &[_]secret_handshake.Signal{.double_blink};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 2);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "close your eyes for 100" {
    const expected = &[_]secret_handshake.Signal{.close_your_eyes};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 4);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "jump for 1000" {
    const expected = &[_]secret_handshake.Signal{.jump};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 8);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "combine two actions" {
    const expected = &[_]secret_handshake.Signal{.wink, .double_blink};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 3);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reverse two actions" {
    const expected = &[_]secret_handshake.Signal{.double_blink, .wink};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 19);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reversing one action gives the same action" {
    const expected = &[_]secret_handshake.Signal{.jump};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 24);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reversing no actions still gives no actions" {
    const expected = &[_]secret_handshake.Signal{};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 16);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "all possible actions" {
    const expected = &[_]secret_handshake.Signal{
        .wink, .double_blink, .close_your_eyes, .jump};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 15);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "reverse all possible actions" {
    const expected = &[_]secret_handshake.Signal{
        .jump, .close_your_eyes, .double_blink, .wink};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 31);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}

test "do nothing for zero" {
    const expected = &[_]secret_handshake.Signal{};
    var actual = try secret_handshake.calculateHandshake(testing.allocator, 0);
    defer testing.allocator.free(actual);
    testing.expectEqualSlices(secret_handshake.Signal, expected, actual);
}
