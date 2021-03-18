const std = @import("std");
const testing = std.testing;

const hamming = @import("hamming.zig");
const DNAError = hamming.DNAError;

test "empty strands" {
    const expected = DNAError.EmptyDNAStrands;
    const actual = comptime hamming.compute("", "");
    testing.expectError(expected, actual);
}

test "single letter identical strands" {
    const expected = 0;
    const actual = comptime try hamming.compute("A", "A");
    testing.expectEqual(expected, actual);
}

test "single letter different strands" {
    const expected = 1;
    const actual = comptime try hamming.compute("G", "T");
    testing.expectEqual(expected, actual);
}

test "long identical strands" {
    const expected = 0;
    const actual = comptime try hamming
        .compute("GGACTGAAATCTG", "GGACTGAAATCTG");
    testing.expectEqual(expected, actual);
}

test "long different strands" {
    const expected = 9;
    const actual = comptime try hamming
        .compute("GGACGGATTCTG", "AGGACGGATTCT");
    testing.expectEqual(expected, actual);
}

test "disallow first strand longer" {
    const expected = DNAError.UnequalDNAStrands;
    const actual = comptime hamming.compute("AATG", "AAA");
    testing.expectError(expected, actual);
}

test "disallow second strand longer" {
    const expected = DNAError.UnequalDNAStrands;
    const actual = comptime hamming.compute("ATA", "AGTG");
    testing.expectError(expected, actual);
}

test "disallow left empty strand" {
    const expected = DNAError.EmptyDNAStrands;
    const actual = comptime hamming.compute("", "G");
    testing.expectError(expected, actual);
}

test "disallow right empty strand" {
    const expected = DNAError.EmptyDNAStrands;
    const actual = comptime hamming.compute("G", "");
    testing.expectError(expected, actual);
}
