const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const rna_transcription = @import("rna_transcription.zig");
const RNAError = rna_transcription.RNAError;

fn testTranscription(
    dna: []const u8,
    expected: []const u8
) !void {
    const rna = try rna_transcription.toRna(testing.allocator, dna);
    try testing.expectEqualStrings(expected, rna);
    testing.allocator.free(rna);
}

fn testFailure(
    dna: []const u8
) !void {
    const expected = RNAError.IllegalDNANucleotide;
    const actual = rna_transcription.toRna(testing.allocator, dna);
    try testing.expectError(expected, actual);
}


test "empty rna sequence" {
    try testTranscription("", "");
}

test "rna complement of cytosine is guanine" {
    try testTranscription("C", "G");
}

test "rna complement of guanine is cytosine" {
    try testTranscription("G", "C");
}

test "rna complement of thymine is adenine" {
    try testTranscription("T", "A");
}

test "rna complement of adenine is uracil" {
    try testTranscription("A", "U");
}

test "rna complement" {
    try testTranscription("ACGTGGTCTTAA", "UGCACCAGAAUU");
}
