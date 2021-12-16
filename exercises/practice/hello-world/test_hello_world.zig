const std = @import("std");
const testing = std.testing;

const hello_world = @import("hello_world.zig");

test "say hi" {
    const expected = "Hello, world!";
    const actual = comptime hello_world.hello();
    comptime try testing.expectEqualStrings(expected, actual);
}
