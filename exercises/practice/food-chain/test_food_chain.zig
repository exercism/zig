const std = @import("std");
const testing = std.testing;

const food_chain = @import("food_chain.zig");

fn testRecite(expected: []const u8, start_verse: u32, end_verse: u32) !void {
    var buffer: [2129]u8 = undefined;
    const actual = try food_chain.recite(&buffer, start_verse, end_verse);
    try testing.expectEqual(@as([*]const u8, &buffer), actual.ptr);
    try testing.expectEqualStrings(expected, actual);
}

test "fly" {
    try testRecite(
        \\I know an old lady who swallowed a fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 1, 1);
}

test "spider" {
    try testRecite(
        \\I know an old lady who swallowed a spider.
        \\It wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 2, 2);
}

test "bird" {
    try testRecite(
        \\I know an old lady who swallowed a bird.
        \\How absurd to swallow a bird!
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 3, 3);
}

test "cat" {
    try testRecite(
        \\I know an old lady who swallowed a cat.
        \\Imagine that, to swallow a cat!
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 4, 4);
}

test "dog" {
    try testRecite(
        \\I know an old lady who swallowed a dog.
        \\What a hog, to swallow a dog!
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 5, 5);
}

test "goat" {
    try testRecite(
        \\I know an old lady who swallowed a goat.
        \\Just opened her throat and swallowed a goat!
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 6, 6);
}

test "cow" {
    try testRecite(
        \\I know an old lady who swallowed a cow.
        \\I don't know how she swallowed a cow!
        \\She swallowed the cow to catch the goat.
        \\She swallowed the goat to catch the dog.
        \\She swallowed the dog to catch the cat.
        \\She swallowed the cat to catch the bird.
        \\She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
        \\She swallowed the spider to catch the fly.
        \\I don't know why she swallowed the fly. Perhaps she'll die.
    , 7, 7);
}

test "horse" {
    try testRecite(
        \\I know an old lady who swallowed a horse.
        \\She's dead, of course!
    , 8, 8);
}

test "multiple verses" {
    try testRecite(
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
    , 1, 3);
}

test "full song" {
    try testRecite(
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
    , 1, 8);
}
