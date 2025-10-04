const std = @import("std");
const testing = std.testing;

const protein_translation = @import("protein_translation.zig");
const proteins = protein_translation.proteins;
const Protein = protein_translation.Protein;
const TranslationError = protein_translation.TranslationError;

test "Empty RNA sequence results in no proteins" {
    const expected = [_]Protein{};
    const actual = try proteins(testing.allocator, "");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Methionine RNA sequence" {
    const expected = [_]Protein{.methionine};
    const actual = try proteins(testing.allocator, "AUG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Phenylalanine RNA sequence 1" {
    const expected = [_]Protein{.phenylalanine};
    const actual = try proteins(testing.allocator, "UUU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Phenylalanine RNA sequence 2" {
    const expected = [_]Protein{.phenylalanine};
    const actual = try proteins(testing.allocator, "UUC");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Leucine RNA sequence 1" {
    const expected = [_]Protein{.leucine};
    const actual = try proteins(testing.allocator, "UUA");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Leucine RNA sequence 2" {
    const expected = [_]Protein{.leucine};
    const actual = try proteins(testing.allocator, "UUG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Serine RNA sequence 1" {
    const expected = [_]Protein{.serine};
    const actual = try proteins(testing.allocator, "UCU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Serine RNA sequence 2" {
    const expected = [_]Protein{.serine};
    const actual = try proteins(testing.allocator, "UCC");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Serine RNA sequence 3" {
    const expected = [_]Protein{.serine};
    const actual = try proteins(testing.allocator, "UCA");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Serine RNA sequence 4" {
    const expected = [_]Protein{.serine};
    const actual = try proteins(testing.allocator, "UCG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Tyrosine RNA sequence 1" {
    const expected = [_]Protein{.tyrosine};
    const actual = try proteins(testing.allocator, "UAU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Tyrosine RNA sequence 2" {
    const expected = [_]Protein{.tyrosine};
    const actual = try proteins(testing.allocator, "UAC");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Cysteine RNA sequence 1" {
    const expected = [_]Protein{.cysteine};
    const actual = try proteins(testing.allocator, "UGU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Cysteine RNA sequence 2" {
    const expected = [_]Protein{.cysteine};
    const actual = try proteins(testing.allocator, "UGC");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Tryptophan RNA sequence" {
    const expected = [_]Protein{.tryptophan};
    const actual = try proteins(testing.allocator, "UGG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "STOP codon RNA sequence 1" {
    const expected = [_]Protein{};
    const actual = try proteins(testing.allocator, "UAA");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "STOP codon RNA sequence 2" {
    const expected = [_]Protein{};
    const actual = try proteins(testing.allocator, "UAG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "STOP codon RNA sequence 3" {
    const expected = [_]Protein{};
    const actual = try proteins(testing.allocator, "UGA");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Sequence of two protein codons translates into proteins" {
    const expected = [_]Protein{ .phenylalanine, .phenylalanine };
    const actual = try proteins(testing.allocator, "UUUUUU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Sequence of two different protein codons translates into proteins" {
    const expected = [_]Protein{ .leucine, .leucine };
    const actual = try proteins(testing.allocator, "UUAUUG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translate RNA strand into correct protein list" {
    const expected = [_]Protein{ .methionine, .phenylalanine, .tryptophan };
    const actual = try proteins(testing.allocator, "AUGUUUUGG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translation stops if STOP codon at beginning of sequence" {
    const expected = [_]Protein{};
    const actual = try proteins(testing.allocator, "UAGUGG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translation stops if STOP codon at end of two-codon sequence" {
    const expected = [_]Protein{.tryptophan};
    const actual = try proteins(testing.allocator, "UGGUAG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translation stops if STOP codon at end of three-codon sequence" {
    const expected = [_]Protein{ .methionine, .phenylalanine };
    const actual = try proteins(testing.allocator, "AUGUUUUAA");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translation stops if STOP codon in middle of three-codon sequence" {
    const expected = [_]Protein{.tryptophan};
    const actual = try proteins(testing.allocator, "UGGUAGUGG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Translation stops if STOP codon in middle of six-codon sequence" {
    const expected = [_]Protein{ .tryptophan, .cysteine, .tyrosine };
    const actual = try proteins(testing.allocator, "UGGUGUUAUUAAUGGUUU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Sequence of two non-STOP codons does not translate to a STOP codon" {
    const expected = [_]Protein{ .methionine, .methionine };
    const actual = try proteins(testing.allocator, "AUGAUG");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}

test "Unknown amino acids, not part of a codon, can't translate" {
    try testing.expectError(TranslationError.InvalidCodon, proteins(testing.allocator, "XYZ"));
}

test "Incomplete RNA sequence can't translate" {
    try testing.expectError(TranslationError.InvalidCodon, proteins(testing.allocator, "AUGU"));
}

test "Incomplete RNA sequence can translate if valid until a STOP codon" {
    const expected = [_]Protein{ .phenylalanine, .phenylalanine };
    const actual = try proteins(testing.allocator, "UUCUUCUAAUGGU");
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Protein, &expected, actual);
}
