const std = @import("std");
const testing = std.testing;

const pangram = @import("pangram.zig");

test "empty sentence" {
    try testing.expect(!pangram.isPangram(""));
}

test "perfect lower case" {
    try testing.expect(pangram.isPangram("abcdefghijklmnopqrstuvwxyz"));
}

test "only lower case" {
    try testing.expect(pangram.isPangram("the quick brown fox jumps over the lazy dog"));
}

test "missing the letter 'x'" {
    try testing.expect(!pangram.isPangram("a quick movement of the enemy will jeopardize five gunboats"));
}

test "missing the letter 'h'" {
    try testing.expect(!pangram.isPangram("five boxing wizards jump quickly at it"));
}

test "with underscores" {
    try testing.expect(pangram.isPangram("the_quick_brown_fox_jumps_over_the_lazy_dog"));
}

test "with numbers" {
    try testing.expect(pangram.isPangram("the 1 quick brown fox jumps over the 2 lazy dogs"));
}

test "missing letters replaced by numbers" {
    try testing.expect(!pangram.isPangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"));
}

test "mixed case and punctuation" {
    try testing.expect(pangram.isPangram("\"Five quacking Zephyrs jolt my wax bed.\""));
}

test "a-m and A-M are 26 different characters but not a pangram" {
    try testing.expect(!pangram.isPangram("abcdefghijklm ABCDEFGHIJKLM"));
}
