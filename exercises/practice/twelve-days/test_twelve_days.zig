const std = @import("std");
const testing = std.testing;

const twelve_days = @import("twelve_days.zig");

test "verse-first day a partridge in a pear tree" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 1, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-second day two turtle doves" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 2, 2);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-third day three french hens" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 3, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-fourth day four calling birds" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 4, 4);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-fifth day five gold rings" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 5, 5);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-sixth day six geese-a-laying" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 6, 6);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-seventh day seven swans-a-swimming" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 7, 7);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-eighth day eight maids-a-milking" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 8, 8);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-ninth day nine ladies dancing" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 9, 9);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-tenth day ten lords-a-leaping" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 10, 10);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-eleventh day eleven pipers piping" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 11, 11);
    try testing.expectEqualStrings(expected, actual);
}

test "verse-twelfth day twelve drummers drumming" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 12, 12);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-recites first three verses of the song" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
        \\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 1, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-recites three verses from the middle of the song" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 4, 6);
    try testing.expectEqualStrings(expected, actual);
}

test "lyrics-recites the whole song" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.
        \\On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
        \\On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
    ;
    const actual = twelve_days.recite(&buffer, 1, 12);
    try testing.expectEqualStrings(expected, actual);
}
