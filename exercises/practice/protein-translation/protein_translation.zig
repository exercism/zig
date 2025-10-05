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

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    _ = allocator;
    _ = strand;
    @compileError("please implement the proteins function");
}
