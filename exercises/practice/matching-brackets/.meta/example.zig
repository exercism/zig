const std = @import("std");
const mem = std.mem;

/// Returns whether the characters `(`, `[`, and `{` are matched and correctly nested in `s`.
pub fn isBalanced(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error!bool {
    var stack = std.ArrayList(u8).init(allocator);
    defer stack.deinit();

    for (s) |c| {
        switch (c) {
            '(', '[', '{' => try stack.append(c),
            ')' => if (stack.items.len == 0 or stack.pop() != '(') return false,
            ']' => if (stack.items.len == 0 or stack.pop() != '[') return false,
            '}' => if (stack.items.len == 0 or stack.pop() != '{') return false,
            else => continue,
        }
    }

    return stack.items.len == 0;
}
