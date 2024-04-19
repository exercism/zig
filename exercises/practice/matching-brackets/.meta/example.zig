const std = @import("std");
const mem = std.mem;

fn toClosing(c: u8) u8 {
    return switch (c) {
        '(' => ')',
        '[' => ']',
        '{' => '}',
        else => unreachable,
    };
}

/// Returns whether the characters `(`, `[`, and `{` are matched and correctly nested in `s`.
/// Caller guarantees that the nesting depth of those characters in `s` is at most 100.
// The tests use `try`, so this function returns `!bool` even though it cannot return an error.
pub fn isBalanced(_: mem.Allocator, s: []const u8) !bool {
    var stack: [100]u8 = undefined;
    var i: usize = 0;

    for (s) |c| {
        switch (c) {
            '(', '[', '{' => {
                stack[i] = toClosing(c);
                i += 1;
            },
            ')', ']', '}' => {
                if (i > 0 and stack[i - 1] == c) i -= 1 else return false;
            },
            else => continue,
        }
    }

    return i == 0;
}
