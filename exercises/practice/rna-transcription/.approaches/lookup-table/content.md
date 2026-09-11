# Lookup table

```zig
const std = @import("std");
const mem = std.mem;

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
    for (dna, rna) |nucleotide, *out| {
        out.* = complement[nucleotide];
    }
    return rna;
}
```

Instead of deciding the complement with control flow, this approach precomputes it.
A 256-entry table — one slot per possible byte value — is built once at compile time, with the four DNA bases filled in.
The [labeled block][labeled-block] `blk: { ... break :blk table; }` runs at `comptime` because it initializes a `const`, so the table is baked into the binary as data rather than constructed at run time.

The loop body is then a single array index, `complement[nucleotide]`, with no branches at all.
Iterating over `dna` and `rna` together binds `out` as a pointer into the result, so the transcribed byte is written straight through it.

The table is deliberately `[256]u8` rather than something smaller: indexing by the raw byte value needs no range check or offset subtraction, and the untouched entries are simply never read for valid input.

[labeled-block]: https://ziglang.org/documentation/master/#Blocks
