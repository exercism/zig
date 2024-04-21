# About

Zig is a general-purpose programming language and toolchain, which aims to help produce **robust**, **optimal**, and **reusable** software.

It does this by striving for simplicity: there's no hidden control flow, no hidden memory allocations, and no macros.
However, there's still a modern design: a powerful type system with sum types and [optionals][optionals], explicit [error handling][error-handling], and [compile-time execution][compile-time].

Zig tries to be a DSL for emitting optimal machine code.

For more information, see [ziglang.org][ziglang.org].

//Zig provides a complete summary of the language's current features, grammar, and philosophy in the [Zig Language Reference][langref].
//It's highly recommended that newcomers use a mix of the documentation and other [community resources][zig-community] to learn Zig in a well-rounded fashion.

// Compatibility with C is as good as it gets: Zig ships with C compiler toolchains, so you can just import a C header file and call functions.
// Zig also provides a [build system][build-system] so that Zig isn't dependent on alternative build tools, such as make, cmake, or ninja.
// And Zig is excellent at cross compilation.

[build-system]: https://ziglang.org/learn/overview/#zig-build-system
[compile-time]: https://ziglang.org/learn/overview/#compile-time-reflection-and-compile-time-code-execution
[error-handling]: https://ziglang.org/learn/overview/#a-fresh-take-on-error-handling
[langref]: https://ziglang.org/documentation/0.12.0/
[optionals]: https://ziglang.org/learn/overview/#optional-type-instead-of-null-pointers
[ziglang.org]: https://ziglang.org/
[zig-community]: https://github.com/ziglang/zig/wiki/Community
