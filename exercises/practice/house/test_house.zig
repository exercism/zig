const std = @import("std");
const testing = std.testing;

const house = @import("house.zig");

fn testRecite(expected: []const u8, start_verse: u32, end_verse: u32) !void {
    var buffer: [2335]u8 = undefined;
    const actual = try house.recite(&buffer, start_verse, end_verse);
    try testing.expectEqual(@as([*]const u8, &buffer), actual.ptr);
    try testing.expectEqualStrings(expected, actual);
}

test "verse one - the house that jack built" {
    try testRecite(
        \\This is the house that Jack built.
    , 1, 1);
}

test "verse two - the malt that lay" {
    try testRecite(
        \\This is the malt that lay in the house that Jack built.
    , 2, 2);
}

test "verse three - the rat that ate" {
    try testRecite(
        \\This is the rat that ate the malt that lay in the house that Jack built.
    , 3, 3);
}

test "verse four - the cat that killed" {
    try testRecite(
        \\This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 4, 4);
}

test "verse five - the dog that worried" {
    try testRecite(
        \\This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 5, 5);
}

test "verse six - the cow with the crumpled horn" {
    try testRecite(
        \\This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 6, 6);
}

test "verse seven - the maiden all forlorn" {
    try testRecite(
        \\This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 7, 7);
}

test "verse eight - the man all tattered and torn" {
    try testRecite(
        \\This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 8, 8);
}

test "verse nine - the priest all shaven and shorn" {
    try testRecite(
        \\This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 9, 9);
}

test "verse 10 - the rooster that crowed in the morn" {
    try testRecite(
        \\This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 10, 10);
}

test "verse 11 - the farmer sowing his corn" {
    try testRecite(
        \\This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 11, 11);
}

test "verse 12 - the horse and the hound and the horn" {
    try testRecite(
        \\This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 12, 12);
}

test "multiple verses" {
    try testRecite(
        \\This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 4, 8);
}

test "full rhyme" {
    try testRecite(
        \\This is the house that Jack built.
        \\This is the malt that lay in the house that Jack built.
        \\This is the rat that ate the malt that lay in the house that Jack built.
        \\This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    , 1, 12);
}
