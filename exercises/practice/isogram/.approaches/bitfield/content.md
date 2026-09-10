# Bit field

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

Since there are only 26 letters, the set of seen letters fits in the bits of a single `u32`: bit `0` stands for `a`/`A` and bit `25` for `z`/`Z`.

Non-letters are skipped with [`std.ascii.isAlphabetic`][is-alphabetic].
For a letter, `c | 0x20` sets the bit that distinguishes lowercase from uppercase in ASCII (`'A'` is `0x41`, `'a'` is `0x61`), converting the letter to lowercase; subtracting `'a'` then yields the letter's index.
The `@intCast` narrows that index to the `u5` shift amount that shifting a `u32` requires.

If the letter's bit is already set in `seen`, a letter has repeated and the function returns `false` immediately, so the input is only scanned as far as the first repeated letter.

Compared with the [bool array approach][approach-bool-array], the state is a single register-sized integer, and set membership and insertion are single bitwise operations.

[is-alphabetic]: https://ziglang.org/documentation/master/std/#std.ascii.isAlphabetic
[approach-bool-array]: https://exercism.org/tracks/zig/exercises/isogram/approaches/bool-array
