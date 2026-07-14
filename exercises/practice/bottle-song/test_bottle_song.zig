const std = @import("std");
const testing = std.testing;

const bottle_song = @import("bottle_song.zig");

fn testRecite(expected: []const u8, start_bottles: u32, take_down: u32) !void {
    var buffer: [1821]u8 = undefined;
    const actual = try bottle_song.recite(&buffer, start_bottles, take_down);
    try testing.expectEqual(@as([*]const u8, &buffer), actual.ptr);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-single verse-first generic verse" {
    try testRecite(
        \\Ten green bottles hanging on the wall,
        \\Ten green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be nine green bottles hanging on the wall.
    , 10, 1);
}

test "verse-single verse-last generic verse" {
    try testRecite(
        \\Three green bottles hanging on the wall,
        \\Three green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be two green bottles hanging on the wall.
    , 3, 1);
}

test "verse-single verse-verse with 2 bottles" {
    try testRecite(
        \\Two green bottles hanging on the wall,
        \\Two green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be one green bottle hanging on the wall.
    , 2, 1);
}

test "verse-single verse-verse with 1 bottle" {
    try testRecite(
        \\One green bottle hanging on the wall,
        \\One green bottle hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be no green bottles hanging on the wall.
    , 1, 1);
}

test "lyrics-multiple verses-first two verses" {
    try testRecite(
        \\Ten green bottles hanging on the wall,
        \\Ten green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be nine green bottles hanging on the wall.
        \\
        \\Nine green bottles hanging on the wall,
        \\Nine green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be eight green bottles hanging on the wall.
    , 10, 2);
}

test "lyrics-multiple verses-last three verses" {
    try testRecite(
        \\Three green bottles hanging on the wall,
        \\Three green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be two green bottles hanging on the wall.
        \\
        \\Two green bottles hanging on the wall,
        \\Two green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be one green bottle hanging on the wall.
        \\
        \\One green bottle hanging on the wall,
        \\One green bottle hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be no green bottles hanging on the wall.
    , 3, 3);
}

test "lyrics-multiple verses-all verses" {
    try testRecite(
        \\Ten green bottles hanging on the wall,
        \\Ten green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be nine green bottles hanging on the wall.
        \\
        \\Nine green bottles hanging on the wall,
        \\Nine green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be eight green bottles hanging on the wall.
        \\
        \\Eight green bottles hanging on the wall,
        \\Eight green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be seven green bottles hanging on the wall.
        \\
        \\Seven green bottles hanging on the wall,
        \\Seven green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be six green bottles hanging on the wall.
        \\
        \\Six green bottles hanging on the wall,
        \\Six green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be five green bottles hanging on the wall.
        \\
        \\Five green bottles hanging on the wall,
        \\Five green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be four green bottles hanging on the wall.
        \\
        \\Four green bottles hanging on the wall,
        \\Four green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be three green bottles hanging on the wall.
        \\
        \\Three green bottles hanging on the wall,
        \\Three green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be two green bottles hanging on the wall.
        \\
        \\Two green bottles hanging on the wall,
        \\Two green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be one green bottle hanging on the wall.
        \\
        \\One green bottle hanging on the wall,
        \\One green bottle hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be no green bottles hanging on the wall.
    , 10, 10);
}
