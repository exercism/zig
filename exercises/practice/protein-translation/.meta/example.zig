const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
};

fn equal(first: []const u8, second: []const u8) bool {
    return std.mem.eql(u8, first, second);
}

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var result = try std.ArrayList(Protein).initCapacity(allocator, strand.len / 3);
    defer result.deinit(allocator);

    var i: usize = 0;
    while (i + 3 <= strand.len) : (i += 3) {
        const codon = strand[i..(i + 3)];
        if (equal(codon, "AUG")) {
            result.appendAssumeCapacity(.methionine);
        } else if (equal(codon, "UUU") or equal(codon, "UUC")) {
            result.appendAssumeCapacity(.phenylalanine);
        } else if (equal(codon, "UUA") or equal(codon, "UUG")) {
            result.appendAssumeCapacity(.leucine);
        } else if (equal(codon, "UCU") or equal(codon, "UCC") or equal(codon, "UCA") or equal(codon, "UCG")) {
            result.appendAssumeCapacity(.serine);
        } else if (equal(codon, "UAU") or equal(codon, "UAC")) {
            result.appendAssumeCapacity(.tyrosine);
        } else if (equal(codon, "UGU") or equal(codon, "UGC")) {
            result.appendAssumeCapacity(.cysteine);
        } else if (equal(codon, "UGG")) {
            result.appendAssumeCapacity(.tryptophan);
        } else if (equal(codon, "UAA") or equal(codon, "UAG") or equal(codon, "UGA")) {
            // Ignore the rest of the sequence — the protein is complete.
            return result.toOwnedSlice(allocator);
        } else {
            // Invalid codon
            break;
        }
    }

    if (i < strand.len) {
        return TranslationError.InvalidCodon;
    }

    return result.toOwnedSlice(allocator);
}
