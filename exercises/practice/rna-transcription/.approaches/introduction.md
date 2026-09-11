# Introduction

Transcription replaces each DNA nucleotide with its RNA complement: `G`↔`C` and `A`→`U`, `T`→`A`. The result is caller-owned memory.

Since the output is the same length as the input and every nucleotide maps independently, every approach allocates a result buffer of `dna.len` bytes and fills it; they differ only in how a single nucleotide is mapped.

## Approach: switch

```zig
pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    for (dna, rna) |nucleotide, *out| {
        out.* = switch (nucleotide) {
            'A' => 'U',
            'C' => 'G',
            'G' => 'C',
            'T' => 'A',
            else => unreachable,
        };
    }
    return rna;
}
```

A `switch` maps each nucleotide to its complement, one character at a time.
For details, see the [switch approach][approach-switch].

## Approach: lookup table

```zig
const complement = blk: {
    var table: [256]u8 = undefined;
    table['A'] = 'U';
    table['C'] = 'G';
    table['G'] = 'C';
    table['T'] = 'A';
    break :blk table;
};

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    for (dna, rna) |nucleotide, *out| out.* = complement[nucleotide];
    return rna;
}
```

A 256-byte table computed at compile time turns each mapping into a single array index, with no branches in the loop.
For details, see the [lookup table approach][approach-lookup-table].

## Approach: SIMD

```zig
fn transcribeBlock(block: Block) Block {
    var rna: Block = block;
    rna = @select(u8, block == @as(Block, @splat('A')), @as(Block, @splat('U')), rna);
    rna = @select(u8, block == @as(Block, @splat('C')), @as(Block, @splat('G')), rna);
    rna = @select(u8, block == @as(Block, @splat('G')), @as(Block, @splat('C')), rna);
    rna = @select(u8, block == @as(Block, @splat('T')), @as(Block, @splat('A')), rna);
    return rna;
}
```

A whole block of nucleotides is loaded into a `@Vector` and transcribed at once with vector compares and selects, processing many characters per iteration.
For details, see the [SIMD approach][approach-simd].

[approach-switch]: https://exercism.org/tracks/zig/exercises/rna-transcription/approaches/switch
[approach-lookup-table]: https://exercism.org/tracks/zig/exercises/rna-transcription/approaches/lookup-table
[approach-simd]: https://exercism.org/tracks/zig/exercises/rna-transcription/approaches/simd
