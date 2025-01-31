const std = @import("std");
const testing = std.testing;

const food_chain = @import("food_chain.zig");

test "fly" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 1, 1);
    try testing.expectEqualStrings(expected, actual);
}

test "spider" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a spider.
        \\It wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 2, 2);
    try testing.expectEqualStrings(expected, actual);
}

test "bird" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a bird.
        \\How absurd to swallow a bird!
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 3, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "cat" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a cat.
        \\Imagine that, to swallow a cat!
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 4, 4);
    try testing.expectEqualStrings(expected, actual);
}

test "dog" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a dog.
        \\What a hog, to swallow a dog!
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 5, 5);
    try testing.expectEqualStrings(expected, actual);
}

test "goat" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a goat.
        \\Just opened her throat and swallowed a goat!
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 6, 6);
    try testing.expectEqualStrings(expected, actual);
}

test "cow" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a cow.
        \\I don't know how she swallowed a cow!
        \\She swallowed the cow to catch the goat.
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 7, 7);
    try testing.expectEqualStrings(expected, actual);
}

test "horse" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a horse.
        \\She's dead, of course!
    ;
    const actual = food_chain.recite(&buffer, 8, 8);
    try testing.expectEqualStrings(expected, actual);
}

test "multiple verses" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a spider.
        \\It wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a bird.
        \\How absurd to swallow a bird!
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    ;
    const actual = food_chain.recite(&buffer, 1, 3);
    try testing.expectEqualStrings(expected, actual);
}

test "full song" {
    const buffer_size = 4000;
    var buffer: [buffer_size]u8 = undefined;
    const expected: []const u8 =
        \\I know an old lady who swallowed a fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a spider.
        \\It wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a bird.
        \\How absurd to swallow a bird!
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a cat.
        \\Imagine that, to swallow a cat!
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a dog.
        \\What a hog, to swallow a dog!
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a goat.
        \\Just opened her throat and swallowed a goat!
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a cow.
        \\I don't know how she swallowed a cow!
        \\She swallowed the cow to catch the goat.
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
        \\
        \\I know an old lady who swallowed a horse.
        \\She's dead, of course!
    ;
    const actual = food_chain.recite(&buffer, 1, 8);
    try testing.expectEqualStrings(expected, actual);
}
