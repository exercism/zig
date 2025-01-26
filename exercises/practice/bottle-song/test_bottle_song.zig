const std = @import("std");
const testing = std.testing;

const bottle_song = @import("bottle_song.zig");

test "verse-single verse-first generic verse" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\Ten green bottles hanging on the wall,
        \\Ten green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be nine green bottles hanging on the wall.
    ;
    const actual = bottle_song.recite(&buffer, 10, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-single verse-last generic verse" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\Three green bottles hanging on the wall,
        \\Three green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be two green bottles hanging on the wall.
    ;
    const actual = bottle_song.recite(&buffer, 3, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-single verse-verse with 2 bottles" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\Two green bottles hanging on the wall,
        \\Two green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be one green bottle hanging on the wall.
    ;
    const actual = bottle_song.recite(&buffer, 2, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-single verse-verse with 1 bottle" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\One green bottle hanging on the wall,
        \\One green bottle hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be no green bottles hanging on the wall.
    ;
    const actual = bottle_song.recite(&buffer, 1, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-multiple verses-first two verses" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\Ten green bottles hanging on the wall,
        \\Ten green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be nine green bottles hanging on the wall.
        \\
        \\Nine green bottles hanging on the wall,
        \\Nine green bottles hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be eight green bottles hanging on the wall.
    ;
    const actual = bottle_song.recite(&buffer, 10, 2);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-multiple verses-last three verses" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
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
    ;
    const actual = bottle_song.recite(&buffer, 3, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-multiple verses-all verses" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
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
    ;
    const actual = bottle_song.recite(&buffer, 10, 10);
    try testing.expectEqualStrings(expected, actual);
}
