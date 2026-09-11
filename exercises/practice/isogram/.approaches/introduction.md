# Introduction

An isogram is a word with no repeated letters, so every approach comes down to detecting whether any letter occurs twice, ignoring case and ignoring characters that are not letters.
The approaches differ in how they remember which letters have already been seen.

## General guidance

Since there are only 26 letters, the state that needs to be tracked is small and of fixed size.
No allocation is needed: an array, an integer, or a vector on the stack is enough.
Case can be ignored by mapping both `'A'...'Z'` and `'a'...'z'` to an index in the range `0...25`.

## Approach: bool array

```zig
pub fn isIsogram(s: []const u8) bool {
    var letters: [26]bool = @splat(false);
    for (s) |c| {
        const i = switch (c) {
            'A'...'Z' => c - 'A',
            'a'...'z' => c - 'a',
            else => continue,
        };
        if (letters[i]) return false;
        letters[i] = true;
    }
    return true;
}
```

Each letter maps to an element of a `[26]bool` array, which records whether the letter has been seen before.
For details, see the [bool array approach][approach-bool-array].

## Approach: bit field

```zig
const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var seen: u32 = 0;
    for (str) |c| {
        if (!std.ascii.isAlphabetic(c)) continue;
        const bit = @as(u32, 1) << @intCast((c | 0x20) - 'a');
        if (seen & bit != 0) return false;
        seen |= bit;
    }
    return true;
}
```

Each letter maps to one bit of a `u32`, so the whole set of seen letters fits in a single integer.
For details, see the [bit field approach][approach-bitfield].

## Approach: SIMD

```zig
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

The input is processed a block of characters at a time: each block is loaded into a `@Vector`, and vector operations lowercase all its characters, find the letters, and turn them into a bit mask in one pass.
For details, see the [SIMD approach][approach-simd].

[approach-bool-array]: https://exercism.org/tracks/zig/exercises/isogram/approaches/bool-array
[approach-bitfield]: https://exercism.org/tracks/zig/exercises/isogram/approaches/bitfield
[approach-simd]: https://exercism.org/tracks/zig/exercises/isogram/approaches/simd
