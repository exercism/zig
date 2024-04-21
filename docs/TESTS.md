# Writing your solution

Write your solution in `<exercise_name>.zig`.
Exercism provides a solution skeleton there for each exercise.

We intend each skeleton to provide a clear starting point, but you don't need to use everything from it.
In general, any solution that passes every test is valid.

However, we recommend continuing after you've got the tests to pass.
Try to refactor, and turn your solution into beautiful idiomatic Zig!

## Running the tests

To test your solution, run the below command in the exercise's root directory:

```bash
zig test test_exercise_name.zig
```

replacing `exercise_name` with the name of the exercise.

By default, the test file enables every test.
That is, no test is currently skipped by default.
To go through tests one at a time, you can [comment out][comments] tests by adding `//` to the start of a line

[comments]: https://ziglang.org/documentation/0.12.0/#Comments
