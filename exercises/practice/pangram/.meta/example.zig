pub fn isPangram(s: []const u8) bool {
    if (s.len < 26) return false;

    var letters: [26]bool = @splat(false);
    for (s) |c| {
        const i = switch (c) {
            'A'...'Z' => c - 'A',
            'a'...'z' => c - 'a',
            else => continue,
        };
        letters[i] = true;
    }
    for (letters) |b| {
        if (!b) return false;
    }
    return true;
}
