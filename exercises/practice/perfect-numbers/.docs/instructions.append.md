# Instructions append

## Assert

For this exercise, let's say that we want the caller to be responsible for calling `classify` only with a nonzero input.
So please make the `classify` function assert that its input is nonzero.
For more details, see the [Zig Language Reference][zig-reference] and the implementation of [`std.debug.assert`][assert].

However, note that this exercise does not currently test an input of 0 (because `std.testing` does [not yet support expecting a panic][proposal]).

[zig-reference]: https://ziglang.org/documentation/0.11.0/#unreachable
[assert]: https://github.com/ziglang/zig/blob/0.11.0/lib/std/debug.zig#L332-L344
[proposal]: https://github.com/ziglang/zig/issues/1356
