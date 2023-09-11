# Instructions append

## BufSet

We suggest that `detectAnagrams` returns a `BufSet`.

A `BufSet` is a set of strings, the same as `StringHashMap(void)`, except that you don't need to copy a key before inserting.
The `BufSet` does that itself.

For more details on hash maps in Zig, see:

- [Hexops - Zig hashmaps explained][zig-hashmaps-explained]
- [Zighelp - Hash Maps][zighelp]
- [Zig Standard Library - `buf_set.zig`][buf-set]

[buf-set]: https://github.com/ziglang/zig/blob/0.11.0/lib/std/buf_set.zig
[zig-hashmaps-explained]: https://devlog.hexops.com/2022/zig-hashmaps-explained/
[zighelp]: https://zighelp.org/chapter-2/#hash-maps
