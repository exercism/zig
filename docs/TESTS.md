# Writing the Code

Write your code in `<exercise_name>.zig`.
Some exercises come with prewritten signatures for specific Zig constructs, such as [constants][constants], [functions][functions], [imports][imports], [structs][structs], and [potentially many more][et-cetera]!

These prewritten signatures are meant to help you towards completing exercises by providing a clear starting point.
However, starting from these signatures is not necessary.
Especially when any written code which passes their tests are perfectly acceptable solutions.

## Running Tests

To run the tests, all you need to do is run the following command:

```bash
zig test test_exercise_name.zig
```

replacing `exercise_name` with the name of the exercise.
The command above has to be run in the exercise's root directory since its test file should be in the same spot.
Additionally, all of the tests for any given exercise are enabled by default, and none of the tests are skippable.

Since all tests have these stipulations, you would have to [comment out][comments] tests that are not passing if you wish to go through each test one by one.
Commenting out a test is as simple as starting each line with a `//`.
Otherwise, when you're confident that your solution can pass the tests, you can un-comment those tests to see if it passes.

[constants]: https://ziglang.org/documentation/master/#Assignment
[comments]: https://ziglang.org/documentation/master/#Comments
[functions]: https://ziglang.org/documentation/master/#Functions
[et-cetera]: https://ziglang.org/documentation/master/
[imports]: https://ziglang.org/documentation/master/#import
[structs]: https://ziglang.org/documentation/master/#struct
