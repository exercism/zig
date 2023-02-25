/// Returns whether the characters `(`, `[`, and `{` are matched and correctly nested in `s`.
/// However, returns `false` if a stack of unmatched characters would exceed a length of 10.
pub fn isPaired(s: []const u8) bool {
    var stack: [10]u8 = undefined;
    var i: u8 = 0;
    for (s) |c| {
        switch (c) {
            '(', '[', '{' => {
                if (i == stack.len) return false;
                stack[i] = c;
                i += 1;
                continue;
            },
            ')' => if (i == 0 or stack[i - 1] != '(') return false,
            ']' => if (i == 0 or stack[i - 1] != '[') return false,
            '}' => if (i == 0 or stack[i - 1] != '{') return false,
            else => continue,
        }
        i -= 1;
    }
    return i == 0;
}
