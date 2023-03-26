const std = @import("std");
const testing = std.testing;

const findAnagrams = @import("anagram.zig").findAnagrams;

test "no matches" {
    const expected = [_][]const u8{};
    const word = "diaper";
    const candidates = [_][]const u8{ "hello", "world", "zombies", "pants" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "detects two anagrams" {
    const expected = [_][]const u8{ "lemons", "melons" };
    const word = "solemn";
    const candidates = [_][]const u8{ "lemons", "cherry", "melons" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "does not detect anagram subsets" {
    const expected = [_][]const u8{};
    const word = "good";
    const candidates = [_][]const u8{ "dog", "goody" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "detects anagram" {
    const expected = [_][]const u8{"inlets"};
    const word = "listen";
    const candidates = [_][]const u8{ "enlists", "google", "inlets", "banana" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "detects three anagrams" {
    const expected = [_][]const u8{ "gallery", "regally", "largely" };
    const word = "allergy";
    const candidates = [_][]const u8{ "gallery", "ballerina", "regally", "clergy", "largely", "leading" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "detects multiple anagrams with different case" {
    const expected = [_][]const u8{ "Eons", "ONES" };
    const word = "nose";
    const candidates = [_][]const u8{ "Eons", "ONES" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "does not detect non-anagrams with identical checksum" {
    const expected = [_][]const u8{};
    const word = "mass";
    const candidates = [_][]const u8{"last"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "detects anagrams case-insensitively" {
    const expected = [_][]const u8{"Carthorse"};
    const word = "Orchestra";
    const candidates = [_][]const u8{ "cashregister", "Carthorse", "radishes" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "detects anagrams using case-insensitive subject" {
    const expected = [_][]const u8{"carthorse"};
    const word = "Orchestra";
    const candidates = [_][]const u8{ "cashregister", "carthorse", "radishes" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "detects anagrams using case-insensitive possible matches" {
    const expected = [_][]const u8{"Carthorse"};
    const word = "orchestra";
    const candidates = [_][]const u8{ "cashregister", "Carthorse", "radishes" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}

test "does not detect an anagram if the original word is repeated" {
    const expected = [_][]const u8{};
    const word = "go";
    const candidates = [_][]const u8{"go Go GO"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "anagrams must use all letters exactly once" {
    const expected = [_][]const u8{};
    const word = "tapper";
    const candidates = [_][]const u8{"patter"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "words are not anagrams of themselves (case-insensitive)" {
    const expected = [_][]const u8{};
    const word = "BANANA";
    const candidates = [_][]const u8{ "BANANA", "Banana", "banana" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "words are not anagrams of themselves" {
    const expected = [_][]const u8{};
    const word = "BANANA";
    const candidates = [_][]const u8{"BANANA"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "words are not anagrams of themselves even if letter case is partially different" {
    const expected = [_][]const u8{};
    const word = "BANANA";
    const candidates = [_][]const u8{"Banana"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "words are not anagrams of themselves even if letter case is completely different" {
    const expected = [_][]const u8{};
    const word = "BANANA";
    const candidates = [_][]const u8{"banana"};
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices([]const u8, &expected, actual);
}

test "words other than themselves can be anagrams" {
    const expected = [_][]const u8{"Silent"};
    const word = "LISTEN";
    const candidates = [_][]const u8{ "LISTEN", "Silent" };
    const actual = try findAnagrams(testing.allocator, word, &candidates);
    defer testing.allocator.free(actual);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}
