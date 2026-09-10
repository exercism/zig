pub fn isIsogram(s: []const u8) bool {
    var letters: [26]bool = @splat(false);
    for (s) |c| {
        const i = switch (c) {
            'A'...'Z' => c - 'A',
            'a'...'z' => c - 'a',
            else => continue,
        };
        if (letters[i]) return false;
        letters[i] = true;
    }
    return true;
}
