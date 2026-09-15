# Instructions append

## Randomness in Zig

The Zig standard library avoids hidden global state, so rather than keeping a random number generator of your own, your functions receive a [`std.Random`][random] interface to draw values from.
The tests pass in a generator seeded with [`std.testing.random_seed`][random-seed], and check that generators with the same seed produce the same characters.

## Checking randomness

The distribution of your ability scores is checked by [chi-squared tests][chi-squared-test] at a [significance level][p-value] of `p < 0.0001`:

- the scores returned by `ability` are compared with the expected distribution;
- each of a character's six abilities is compared with the expected distribution;
- the pattern of odd and even scores across a character's six abilities is compared with what independent abilities would produce.

A correct implementation has less than a 0.01% chance of failing each test.

Note that, according to the instructions, an ability score is _the sum of the three largest results out of four rolls of an unbiased d6 (six-sided die)_.

[random]: https://ziglang.org/documentation/0.16.0/std/#std.Random
[random-seed]: https://ziglang.org/documentation/0.16.0/std/#std.testing.random_seed
[chi-squared-test]: https://en.wikipedia.org/wiki/Pearson%27s_chi-squared_test
[p-value]: https://en.wikipedia.org/wiki/P-value
