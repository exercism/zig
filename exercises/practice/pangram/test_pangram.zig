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

test "non-alphanumeric printable ASCII" {
    try testing.expect(!pangram.isPangram(" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"));
}

test "test edge cases, missing an aplha at a time, plus whole ascii" {
    var sequence: [256]u8 = undefined;

    //fill in all ascii letters
    inline for (0..sequence.len) |index| {
        sequence[index] = @intCast(index);
    }

    const A_UPPER_START = 'A';
    const A_LOWER_START = 'a';
    const DISTANCE_z_a = 'z' - 'a';
    for (0..DISTANCE_z_a + 1) |_offset| {
        const pre_offset: u8 = @intCast(_offset);
        sequence[pre_offset + A_UPPER_START] = 0;
        sequence[pre_offset + A_LOWER_START] = 0;

        try testing.expect(false == pangram.isPangram(&sequence));

        //restore the nulled letter
        sequence[pre_offset + A_UPPER_START] = A_UPPER_START + pre_offset;
        sequence[pre_offset + A_LOWER_START] = A_LOWER_START + pre_offset;
    }
    try testing.expect(pangram.isPangram(&sequence));
}
