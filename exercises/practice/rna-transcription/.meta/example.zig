const std = @import("std");
const mem = std.mem;

pub const RNAError = error {
    IllegalDNANucleotide,
};

pub fn toRna(
    allocator: mem.Allocator,
    dna: []const u8
) ![]const u8 {
    var rna_slice = try allocator.alloc(u8, dna.len);
    for (dna) |dna_nucleotide, i| {
        switch (dna_nucleotide) {
            'A' => rna_slice[i] = 'U',
            'C' => rna_slice[i] = 'G',
            'G' => rna_slice[i] = 'C',
            'T' => rna_slice[i] = 'A',
            else => {
                allocator.free(rna_slice);
                return RNAError.IllegalDNANucleotide;
            },
        }
    }
    return rna_slice;
}
