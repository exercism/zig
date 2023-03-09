const std = @import("std");
const mem = std.mem;
const testing = std.testing;

const rna_transcription = @import("rna_transcription.zig");
const RnaError = rna_transcription.RnaError;

fn testTranscription(dna: []const u8, expected: []const u8) !void {
    const rna = try rna_transcription.toRna(testing.allocator, dna);
    try testing.expectEqualStrings(expected, rna);
    testing.allocator.free(rna);
}

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "empty rna sequence" {
    try testTranscription("", "");
}

test "rna complement of cytosine is guanine" {
    // Delete or comment out below line to run test
    try skipTest();

    try testTranscription("C", "G");
}

test "rna complement of guanine is cytosine" {
    // Delete or comment out below line to run test
    try skipTest();

    try testTranscription("G", "C");
}

test "rna complement of thymine is adenine" {
    // Delete or comment out below line to run test
    try skipTest();

    try testTranscription("T", "A");
}

test "rna complement of adenine is uracil" {
    // Delete or comment out below line to run test
    try skipTest();

    try testTranscription("A", "U");
}

test "rna complement" {
    // Delete or comment out below line to run test
    try skipTest();

    try testTranscription("ACGTGGTCTTAA", "UGCACCAGAAUU");
}
