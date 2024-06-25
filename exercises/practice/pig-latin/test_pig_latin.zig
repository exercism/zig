const std = @import("std");
const testing = std.testing;

const pig_latin = @import("pig_latin.zig");

test "ay is added to words that start with vowels-word beginning with a" {
    const expected: []const u8 = "appleay";
    const actual = try pig_latin.translate(testing.allocator, "apple");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "ay is added to words that start with vowels-word beginning with e" {
    const expected: []const u8 = "earay";
    const actual = try pig_latin.translate(testing.allocator, "ear");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "ay is added to words that start with vowels-word beginning with i" {
    const expected: []const u8 = "iglooay";
    const actual = try pig_latin.translate(testing.allocator, "igloo");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "ay is added to words that start with vowels-word beginning with o" {
    const expected: []const u8 = "objectay";
    const actual = try pig_latin.translate(testing.allocator, "object");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "ay is added to words that start with vowels-word beginning with u" {
    const expected: []const u8 = "underay";
    const actual = try pig_latin.translate(testing.allocator, "under");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "ay is added to words that start with vowels-word beginning with a vowel and followed by a qu" {
    const expected: []const u8 = "equalay";
    const actual = try pig_latin.translate(testing.allocator, "equal");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "first letter and ay are moved to the end of words that start with consonants-word beginning with p" {
    const expected: []const u8 = "igpay";
    const actual = try pig_latin.translate(testing.allocator, "pig");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "first letter and ay are moved to the end of words that start with consonants-word beginning with k" {
    const expected: []const u8 = "oalakay";
    const actual = try pig_latin.translate(testing.allocator, "koala");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "first letter and ay are moved to the end of words that start with consonants-word beginning with x" {
    const expected: []const u8 = "enonxay";
    const actual = try pig_latin.translate(testing.allocator, "xenon");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "first letter and ay are moved to the end of words that start with consonants-word beginning with q without a following u" {
    const expected: []const u8 = "atqay";
    const actual = try pig_latin.translate(testing.allocator, "qat");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with ch" {
    const expected: []const u8 = "airchay";
    const actual = try pig_latin.translate(testing.allocator, "chair");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with qu" {
    const expected: []const u8 = "eenquay";
    const actual = try pig_latin.translate(testing.allocator, "queen");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with qu and a preceding consonant" {
    const expected: []const u8 = "aresquay";
    const actual = try pig_latin.translate(testing.allocator, "square");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with th" {
    const expected: []const u8 = "erapythay";
    const actual = try pig_latin.translate(testing.allocator, "therapy");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with thr" {
    const expected: []const u8 = "ushthray";
    const actual = try pig_latin.translate(testing.allocator, "thrush");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single consonant-word beginning with sch" {
    const expected: []const u8 = "oolschay";
    const actual = try pig_latin.translate(testing.allocator, "school");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single vowel-word beginning with yt" {
    const expected: []const u8 = "yttriaay";
    const actual = try pig_latin.translate(testing.allocator, "yttria");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "some letter clusters are treated like a single vowel-word beginning with xr" {
    const expected: []const u8 = "xrayay";
    const actual = try pig_latin.translate(testing.allocator, "xray");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "position of y in a word determines if it is a consonant or a vowel-y is treated like a consonant at the beginning of a word" {
    const expected: []const u8 = "ellowyay";
    const actual = try pig_latin.translate(testing.allocator, "yellow");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "position of y in a word determines if it is a consonant or a vowel-y is treated like a vowel at the end of a consonant cluster" {
    const expected: []const u8 = "ythmrhay";
    const actual = try pig_latin.translate(testing.allocator, "rhythm");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "position of y in a word determines if it is a consonant or a vowel-y as second letter in two letter word" {
    const expected: []const u8 = "ymay";
    const actual = try pig_latin.translate(testing.allocator, "my");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}

test "phrases are translated-a whole phrase" {
    const expected: []const u8 = "ickquay astfay unray";
    const actual = try pig_latin.translate(testing.allocator, "quick fast run");
    defer testing.allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
