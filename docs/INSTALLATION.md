# Installation

You can download Zig from the [Releases][zig-download] page, or [using a package manager][package-manager].

## Supported Zig version

Exercism currently supports Zig 0.12.0 (released on 2024-04-20) only.

An exercise may be compatible with a different Zig version, but that isn't guaranteed.
Zig hasn't yet reached version 1.0, and breaking changes are common.

## The Zig Language Server - comprehensive editor support for Zig

This third-party software provides editor completions and enhanced Zig code navigation features, which can help you learn the language faster.

You can install ZLS [here][zls-install].

## Other commands

### `zig fmt`

The Zig executable contains a code formatter.
To format `file.zig`, run:

```bash
zig fmt file.zig
```

For more details on the suggested code style, see the [Zig Style Guide][style-guide].

### `zig zen`

The Zig executable has a command to remind us of Zig's design goals:

```bash
zig zen
```

[package-manager]: https://github.com/ziglang/zig/wiki/Install-Zig-from-a-Package-Manager
[style-guide]: https://ziglang.org/documentation/0.12.0/#Style-Guide
[zig-download]: https://ziglang.org/download/
[zls-install]: https://install.zigtools.org/
