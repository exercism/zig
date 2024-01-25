# Instructions append

## Error handling

For this exercise you must add an error set `ComputationError` that contains the `IllegalArgument` error.
Remember to make it public!
The `steps` function must return `ComputationError.IllegalArgument` when its input is equal to zero.

Later exercises will usually omit explicit instructions like this.
In general, Exercism expects you to read the test file when implementing your solution.

For more details about errors in Zig, see:

- [Learning Zig - Errors][learning-zig-errors]
- [Ziglings - Exercise 21][ziglings-exercise-21]
- [Zighelp - Errors][zighelp-errors]

[learning-zig-errors]: https://www.openmymind.net/learning_zig/language_overview_2/#errors
[zighelp-errors]: https://zighelp.org/chapter-1/#errors
[ziglings-exercise-21]: https://codeberg.org/ziglings/exercises/src/commit/0d46acfa02d0c29fdfb3651e82a77284dd8f2e00/exercises/021_errors.zig
