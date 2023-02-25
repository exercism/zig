const std = @import("std");
const testing = std.testing;

const nucleotide_count = @import("nucleotide_count.zig");
const countNucleotides = nucleotide_count.countNucleotides;

test "empty strand" {
    const expected = [4]u8{ 0, 0, 0, 0 };
    const actual = try countNucleotides("");
    try testing.expectEqual(expected, actual);
}

test "can count one nucleotide in single-character input" {
    const expected = [4]u8{ 0, 0, 1, 0 };
    const actual = try countNucleotides("G");
    try testing.expectEqual(expected, actual);
}

test "strand with repeated nucleotide" {
    const expected = [4]u8{ 0, 0, 7, 0 };
    const actual = try countNucleotides("GGGGGGG");
    try testing.expectEqual(expected, actual);
}

test "strand with multiple nucleotides" {
    const expected = [4]u8{ 20, 12, 17, 21 };
    const actual = try countNucleotides("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC");
    try testing.expectEqual(expected, actual);
}

test "strand with invalid nucleotides" {
    const expected = nucleotide_count.NucleotideError.Invalid;
    const actual = countNucleotides("AGXXACT");
    try testing.expectError(expected, actual);
}
