const std = @import("std");
const testing = std.testing;

const score = @import("scrabble_score.zig").score;

test "lowercase letter" {
    const expected: usize = 1;
    const actual = score("a");
    try testing.expectEqual(expected, actual);
}

test "uppercase letter" {
    const expected: usize = 1;
    const actual = score("A");
    try testing.expectEqual(expected, actual);
}

test "valuable letter" {
    const expected: usize = 4;
    const actual = score("f");
    try testing.expectEqual(expected, actual);
}

test "short word" {
    const expected: usize = 2;
    const actual = score("at");
    try testing.expectEqual(expected, actual);
}

test "short, valuable word" {
    const expected: usize = 12;
    const actual = score("zoo");
    try testing.expectEqual(expected, actual);
}

test "medium word" {
    const expected: usize = 6;
    const actual = score("street");
    try testing.expectEqual(expected, actual);
}

test "medium, valuable word" {
    const expected: usize = 22;
    const actual = score("quirky");
    try testing.expectEqual(expected, actual);
}

test "long, mixed-case word" {
    const expected: usize = 41;
    const actual = score("OxyphenButazone");
    try testing.expectEqual(expected, actual);
}

test "english-like word" {
    const expected: usize = 8;
    const actual = score("pinata");
    try testing.expectEqual(expected, actual);
}

test "empty input" {
    const expected: usize = 0;
    const actual = score("");
    try testing.expectEqual(expected, actual);
}

test "entire alphabet available" {
    const expected: usize = 87;
    const actual = score("abcdefghijklmnopqrstuvwxyz");
    try testing.expectEqual(expected, actual);
}
