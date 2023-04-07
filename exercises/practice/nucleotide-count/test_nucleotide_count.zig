const std = @import("std");
const testing = std.testing;

const nucleotide_count = @import("nucleotide_count.zig");
const countNucleotides = nucleotide_count.countNucleotides;

test "empty strand" {
    const actual = try countNucleotides("");
    try testing.expectEqual(@as(u32, 0), actual.a);
    try testing.expectEqual(@as(u32, 0), actual.c);
    try testing.expectEqual(@as(u32, 0), actual.g);
    try testing.expectEqual(@as(u32, 0), actual.t);
}

test "can count one nucleotide in single-character input" {
    const actual = try countNucleotides("G");
    try testing.expectEqual(@as(u32, 0), actual.a);
    try testing.expectEqual(@as(u32, 0), actual.c);
    try testing.expectEqual(@as(u32, 1), actual.g);
    try testing.expectEqual(@as(u32, 0), actual.t);
}

test "strand with repeated nucleotide" {
    const actual = try countNucleotides("GGGGGGG");
    try testing.expectEqual(@as(u32, 0), actual.a);
    try testing.expectEqual(@as(u32, 0), actual.c);
    try testing.expectEqual(@as(u32, 7), actual.g);
    try testing.expectEqual(@as(u32, 0), actual.t);
}

test "strand with multiple nucleotides" {
    const actual = try countNucleotides("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC");
    try testing.expectEqual(@as(u32, 20), actual.a);
    try testing.expectEqual(@as(u32, 12), actual.c);
    try testing.expectEqual(@as(u32, 17), actual.g);
    try testing.expectEqual(@as(u32, 21), actual.t);
}

test "strand with invalid nucleotides" {
    const actual = countNucleotides("AGXXACT");
    try testing.expectError(nucleotide_count.NucleotideError.Invalid, actual);
}
