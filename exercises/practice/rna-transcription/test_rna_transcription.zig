const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const rna_transcription = @import("rna_transcription.zig");
const RNAError = rna_transcription.RNAError;

fn test_transcription(
    dna: []const u8,
    expected: []const u8
) (rna_transcription.RNAError || mem.Allocator.Error)!void {
    const rna = try rna_transcription.toRna(testing.allocator, dna);
    testing.expectEqualStrings(expected, rna);
    testing.allocator.free(rna);
}

fn test_failure(
    dna: []const u8
) (rna_transcription.RNAError || mem.Allocator.Error)!void {
    const expected = RNAError.IllegalDNANucleotide;
    const actual = rna_transcription.toRna(testing.allocator, dna);
    testing.expectError(expected, actual);
}


test "empty rna sequence" {
    try test_transcription("", "");
}

test "rna complement of cytosine is guanine" {
    try test_transcription("C", "G");
}

test "rna complement of guanine is cytosine" {
    try test_transcription("G", "C");
}

test "rna complement of thymine is adenine" {
    try test_transcription("T", "A");
}

test "rna complement of adenine is uracil" {
    try test_transcription("A", "U");
}

test "rna complement" {
    try test_transcription("ACGTGGTCTTAA", "UGCACCAGAAUU");
}
