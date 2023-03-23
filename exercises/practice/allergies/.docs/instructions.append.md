# Instructions append

## `EnumSet`

It may be helpful to look at the implementation of [`std.enums.EnumSet`][enumset].

### Compatibility

The development version of Zig contains [new `EnumSet` functions][new-enumset-functions], but Exercism currently uses Zig 0.10.1 (the latest release) to run the tests.

Therefore, for example, a correct solution that uses the new `initEmpty()` will fail the tests on Exercism (at least until Zig 0.11.0 is released).
Sorry.
You don't need those functions for this exercise, though.

[enumset]: https://github.com/ziglang/zig/blob/0.10.1/lib/std/enums.zig#L220-L246
[new-enumset-functions]: https://github.com/ziglang/zig/commit/a792e13fc08982e79cb1b08d14322be76b8cf77a
