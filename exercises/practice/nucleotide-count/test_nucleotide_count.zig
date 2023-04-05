const std = @import("std");
const testing = std.testing;

const nucleotide_count = @import("nucleotide_count.zig");
const countNucleotides = nucleotide_count.countNucleotides;

test "empty strand" {
    const expected = nucleotide_count.Nucleotides{ .a = 0, .c = 0, .g = 0, .t = 0 };
    const actual = try countNucleotides("");
    try testing.expectEqual(expected, actual);
}

test "can count one nucleotide in single-character input" {
    const expected = nucleotide_count.Nucleotides{ .a = 0, .c = 0, .g = 1, .t = 0 };
    const actual = try countNucleotides("G");
    try testing.expectEqual(expected, actual);
}

test "strand with repeated nucleotide" {
    const expected = nucleotide_count.Nucleotides{ .a = 0, .c = 0, .g = 7, .t = 0 };
    const actual = try countNucleotides("GGGGGGG");
    try testing.expectEqual(expected, actual);
}

test "strand with multiple nucleotides" {
    const expected = nucleotide_count.Nucleotides{ .a = 20, .c = 12, .g = 17, .t = 21 };
    const actual = try countNucleotides("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC");
    try testing.expectEqual(expected, actual);
}

test "strand with invalid nucleotides" {
    const expected = nucleotide_count.NucleotideError.Invalid;
    const actual = countNucleotides("AGXXACT");
    try testing.expectError(expected, actual);
}
