const std = @import("std");
const testing = std.testing;

const house = @import("house.zig");

test "verse one - the house that jack built" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the house that Jack built.
    ;
    const actual = house.recite(&buffer, 1, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "verse two - the malt that lay" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 2, 2);
    try testing.expectEqualStrings(expected, actual);
}

test "verse three - the rat that ate" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 3, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "verse four - the cat that killed" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 4, 4);
    try testing.expectEqualStrings(expected, actual);
}

test "verse five - the dog that worried" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 5, 5);
    try testing.expectEqualStrings(expected, actual);
}

test "verse six - the cow with the crumpled horn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 6, 6);
    try testing.expectEqualStrings(expected, actual);
}

test "verse seven - the maiden all forlorn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 7, 7);
    try testing.expectEqualStrings(expected, actual);
}

test "verse eight - the man all tattered and torn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 8, 8);
    try testing.expectEqualStrings(expected, actual);
}

test "verse nine - the priest all shaven and shorn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 9, 9);
    try testing.expectEqualStrings(expected, actual);
}

test "verse 10 - the rooster that crowed in the morn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 10, 10);
    try testing.expectEqualStrings(expected, actual);
}

test "verse 11 - the farmer sowing his corn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 11, 11);
    try testing.expectEqualStrings(expected, actual);
}

test "verse 12 - the horse and the hound and the horn" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 12, 12);
    try testing.expectEqualStrings(expected, actual);
}

test "multiple verses" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\This is the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
        \\This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.
    ;
    const actual = house.recite(&buffer, 4, 8);
    try testing.expectEqualStrings(expected, actual);
}

test "full rhyme" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
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
    ;
    const actual = house.recite(&buffer, 1, 12);
    try testing.expectEqualStrings(expected, actual);
}
