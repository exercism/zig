# Bool array

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

A `[26]bool` array records which letters have been seen so far, with element `0` standing for `a`/`A` and element `25` for `z`/`Z`.

The `switch` maps both uppercase and lowercase letters to that shared index, so case is ignored.
Its `else` prong uses `continue` as the prong body, skipping hyphens, spaces, and any other non-letter directly from within the switch — no separate `if` is needed.

For each letter, if its flag is already set, a letter has repeated and the function returns `false` immediately.
Otherwise the flag is set and scanning continues.
The early return means the input is only scanned as far as the first repeated letter.

The array lives on the stack and its size is known at compile time, so this approach performs no allocation.
