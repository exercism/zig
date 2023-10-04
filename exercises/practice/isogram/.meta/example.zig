pub fn isIsogram(s: []const u8) bool {
    var letters = [_]bool{false} ** 26;
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
