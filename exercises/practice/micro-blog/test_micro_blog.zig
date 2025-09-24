const std = @import("std");
const testing = std.testing;

const micro_blog = @import("micro_blog.zig");

test "English language short" {
    const expected: []const u8 = "Hi";
    const actual = micro_blog.truncate("Hi");
    try testing.expectEqualStrings(expected, actual);
}

test "English language long" {
    const expected: []const u8 = "Hello";
    const actual = micro_blog.truncate("Hello there");
    try testing.expectEqualStrings(expected, actual);
}

test "German language short (broth)" {
    const expected: []const u8 = "brühe";
    const actual = micro_blog.truncate("brühe");
    try testing.expectEqualStrings(expected, actual);
}

test "German language long (bear carpet → beards)" {
    const expected: []const u8 = "Bärte";
    const actual = micro_blog.truncate("Bärteppich");
    try testing.expectEqualStrings(expected, actual);
}

test "Bulgarian language short (good)" {
    const expected: []const u8 = "Добър";
    const actual = micro_blog.truncate("Добър");
    try testing.expectEqualStrings(expected, actual);
}

test "Greek language short (health)" {
    const expected: []const u8 = "υγειά";
    const actual = micro_blog.truncate("υγειά");
    try testing.expectEqualStrings(expected, actual);
}

test "Maths short" {
    const expected: []const u8 = "a=πr²";
    const actual = micro_blog.truncate("a=πr²");
    try testing.expectEqualStrings(expected, actual);
}

test "Maths long" {
    const expected: []const u8 = "∅⊊ℕ⊊ℤ";
    const actual = micro_blog.truncate("∅⊊ℕ⊊ℤ⊊ℚ⊊ℝ⊊ℂ");
    try testing.expectEqualStrings(expected, actual);
}

test "English and emoji short" {
    const expected: []const u8 = "Fly 🛫";
    const actual = micro_blog.truncate("Fly 🛫");
    try testing.expectEqualStrings(expected, actual);
}

test "Emoji short" {
    const expected: []const u8 = "💇";
    const actual = micro_blog.truncate("💇");
    try testing.expectEqualStrings(expected, actual);
}

test "Emoji long" {
    const expected: []const u8 = "❄🌡🤧🤒🏥";
    const actual = micro_blog.truncate("❄🌡🤧🤒🏥🕰😀");
    try testing.expectEqualStrings(expected, actual);
}

test "Royal Flush?" {
    const expected: []const u8 = "🃎🂸🃅🃋🃍";
    const actual = micro_blog.truncate("🃎🂸🃅🃋🃍🃁🃊");
    try testing.expectEqualStrings(expected, actual);
}

test "ideograms" {
    const expected: []const u8 = "二兎を追う";
    const actual = micro_blog.truncate("二兎を追う者は一兎をも得ず");
    try testing.expectEqualStrings(expected, actual);
}
