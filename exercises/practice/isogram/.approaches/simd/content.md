# SIMD

```zig
const std = @import("std");

const block_len = std.simd.suggestVectorLength(u8) orelse 8;
const Block = @Vector(block_len, u8);

/// Returns a bit mask of the letters in `block`, or null if `block`
/// contains a repeated letter.
fn letterMask(block: Block) ?u32 {
    const lowered = block | @as(Block, @splat(0x20));
    // Every non-letter lane is clamped into an extra bucket, index 26.
    const indices = @min(lowered -% @as(Block, @splat('a')), @as(Block, @splat(26)));
    const bits = @as(@Vector(block_len, u32), @splat(1)) << @intCast(indices);
    const mask = @reduce(.Or, bits) & ((1 << 26) - 1);
    const letter_count = std.simd.countTrues(indices != @as(Block, @splat(26)));
    if (@popCount(mask) != letter_count) return null;
    return mask;
}

pub fn isIsogram(str: []const u8) bool {
    var seen: u32 = 0;
    var i: usize = 0;
    while (i + block_len <= str.len) : (i += block_len) {
        const mask = letterMask(str[i..][0..block_len].*) orelse return false;
        if (seen & mask != 0) return false;
        seen |= mask;
    }
    // Pad the remaining bytes with zeroes to fill one last block.
    var padded = [_]u8{0} ** block_len;
    @memcpy(padded[0 .. str.len - i], str[i..]);
    const mask = letterMask(padded) orelse return false;
    return seen & mask == 0;
}
```

Zig's [`@Vector`][vectors] type provides portable SIMD: an operation on vectors is applied to all elements at once, and compiles to the target's vector instructions where available.
Instead of examining one character per loop iteration, this approach loads a whole block of input characters into a vector and processes them together, following the pattern described in [Everyone Should Know SIMD][mitchellh-simd].

[`std.simd.suggestVectorLength`][suggest-vector-length] picks the block length the target's vector registers can hold — for example 32 on x86-64 with AVX2 — and returns `null` for targets without SIMD support, so a fallback is provided.

Like the [bit field approach][approach-bitfield], the set of letters seen so far is kept as bits of a `u32`.
The work of turning a block of characters into such a bit mask is done entirely with vector operations in `letterMask`:

- `block | @splat(0x20)` sets the bit that distinguishes lowercase from uppercase in ASCII, converting every uppercase letter in the block to lowercase in one operation.
- Subtracting `'a'` gives each letter's index in the range `0...25`.
  The subtraction is wrapping (`-%`), so a non-letter lane ends up with some value of at least 26, and `@min` clamps it to exactly 26 — an extra bucket where all the non-letters land.
- Each lane's index becomes a single set bit with a vector shift, and `@reduce(.Or, bits)` collapses the lanes into a single integer holding the set of letters in the block.
  Masking with `(1 << 26) - 1` strips bit 26, throwing away the non-letter bucket.

A repeated letter *within* the block would produce the same bit in two lanes, and the duplicate would vanish in the `Or` reduction.
The `@popCount` check catches this: if the number of distinct bits in the mask differs from the number of letter lanes ([`std.simd.countTrues`][count-trues] of the lanes whose index is not 26), some letter occurred twice.
Repeats *across* blocks are caught by intersecting each block's mask with the accumulated `seen` set, exactly as in the bit field approach.

The final partial block is copied into a zero-padded buffer and processed the same way — padding is safe because `0 | 0x20` is `0x20` (a space), which is not a letter.
This keeps a single code path instead of a separate scalar loop for the tail.

For this exercise's short words, the setup cost of SIMD outweighs its benefit, and the [bool array][approach-bool-array] or bit field approaches are simpler.
The technique shines on long inputs, where each iteration consumes `block_len` characters instead of one.

[vectors]: https://ziglang.org/documentation/master/#Vectors
[suggest-vector-length]: https://ziglang.org/documentation/master/std/#std.simd.suggestVectorLength
[count-trues]: https://ziglang.org/documentation/master/std/#std.simd.countTrues
[mitchellh-simd]: https://mitchellh.com/writing/everyone-should-know-simd
[approach-bool-array]: https://exercism.org/tracks/zig/exercises/isogram/approaches/bool-array
[approach-bitfield]: https://exercism.org/tracks/zig/exercises/isogram/approaches/bitfield
