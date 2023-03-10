const std = @import("std");
const testing = std.testing;

const hello_world = @import("hello_world.zig");

test "say hi!" {
    const expected = "Hello, World!";
    const actual = hello_world.hello();
    try testing.expectEqualStrings(expected, actual);
}
