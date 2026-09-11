# Contributions for Exercism Zig Track

We 💙 our community but **this repository does not accept unsolicited pull requests at this time**.

Please read this [community blog post][guidelines] for details.

## How to contribute

1. Open a topic [in the forum][zig-forum] — for bug reports, feature ideas, or questions about the track, including anything you'd otherwise file as an issue.
1. Discuss the proposal with the maintainers.
1. Once you have a go-ahead, submit a pull request that adheres to [Exercism's style guide][style].

If the PR touches an existing exercise, please also consider [this warning][unnecessary-test-runs] in the documentation for [building tracks][building-tracks].

## Running Tests

Exercises can be tested against the locally installed Zig compiler using

```bash
bin/run-tests
```

Exercises can be tested against the test runner using

```bash
bin/verify-exercises-in-docker
```

[guidelines]: https://exercism.org/blog/contribution-guidelines-nov-2023
[zig-forum]: https://forum.exercism.org/c/programming/zig/199
[building-tracks]: https://exercism.org/docs/building/tracks
[style]: https://exercism.org/docs/building/markdown/style-guide
[unnecessary-test-runs]: https://exercism.org/docs/building/tracks#h-avoiding-triggering-unnecessary-test-runs
