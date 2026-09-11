# SIMD

```zig
const std = @import("std");
const mem = std.mem;

const block_len = std.simd.suggestVectorLength(u8) orelse 8;
const Block = @Vector(block_len, u8);

/// Transcribes a whole block of DNA nucleotides at once.
fn transcribeBlock(block: Block) Block {
    // Every base is replaced; the seed only survives for bytes that are not
    // a base, which valid DNA never contains.
    var rna: Block = block;
    rna = @select(u8, block == @as(Block, @splat('A')), @as(Block, @splat('U')), rna);
    rna = @select(u8, block == @as(Block, @splat('C')), @as(Block, @splat('G')), rna);
    rna = @select(u8, block == @as(Block, @splat('G')), @as(Block, @splat('C')), rna);
    rna = @select(u8, block == @as(Block, @splat('T')), @as(Block, @splat('A')), rna);
    return rna;
}

fn transcribe(nucleotide: u8) u8 {
    return switch (nucleotide) {
        'A' => 'U',
        'C' => 'G',
        'G' => 'C',
        'T' => 'A',
        else => unreachable,
    };
}

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    var i: usize = 0;
    while (i + block_len <= dna.len) : (i += block_len) {
        rna[i..][0..block_len].* = transcribeBlock(dna[i..][0..block_len].*);
    }
    // Transcribe the remaining nucleotides one at a time.
    for (dna[i..], rna[i..]) |nucleotide, *out| {
        out.* = transcribe(nucleotide);
    }
    return rna;
}
```

Zig's [`@Vector`][vectors] type provides portable SIMD: an operation on a vector is applied to all of its elements at once, compiling to the target's vector instructions where available.
Rather than transcribe one nucleotide per iteration, this approach loads a whole block of them into a vector and transcribes the block in one pass, following the pattern in [Everyone Should Know SIMD][mitchellh-simd].

[`std.simd.suggestVectorLength`][suggest-vector-length] picks a block length the target's vector registers can hold — for example 32 on x86-64 with AVX2 — and returns `null` on targets without SIMD, so a fallback of `8` is supplied.

`transcribeBlock` handles all four bases the same way: one [`@select`][select] per base, each comparing the whole block against that base and, in the lanes that match, replacing the running result with its complement (`'A'`→`'U'`, `'C'`→`'G'`, `'G'`→`'C'`, `'T'`→`'A'`).
A lane matches at most one base, so the order of the selects does not matter.
The seed value is the input block itself; for valid DNA every lane matches exactly one base and is overwritten, so the seed only shows through for bytes that are not a base.

The main loop copies `block_len` bytes out of `dna`, transcribes them, and stores the vector straight into the matching slice of `rna` — `dna[i..][0..block_len].*` dereferences a slice as a fixed-size array, which coerces to the vector, and the store on the left does the reverse.

Any nucleotides past the last full block are handled by a scalar `switch`, reusing the same mapping as the [switch approach][approach-switch].
Unlike the isogram-style problems, transcription has no notion of an "invalid" block, so the tail needs no special padding — just a short remainder loop.

The loop body is branch-free and consumes many nucleotides at once, so this is the fastest approach on long sequences.
The trade-off is the most code and the need to reason about lane-wise selection and the scalar tail; for short input the simpler [switch][approach-switch] or [lookup table][approach-lookup-table] approaches are preferable.

[vectors]: https://ziglang.org/documentation/master/#Vectors
[suggest-vector-length]: https://ziglang.org/documentation/master/std/#std.simd.suggestVectorLength
[select]: https://ziglang.org/documentation/master/#select
[mitchellh-simd]: https://mitchellh.com/writing/everyone-should-know-simd
[approach-switch]: https://exercism.org/tracks/zig/exercises/rna-transcription/approaches/switch
[approach-lookup-table]: https://exercism.org/tracks/zig/exercises/rna-transcription/approaches/lookup-table
