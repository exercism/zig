pub fn isValidIsbn10(s: []const u8) bool {
    if (s.len < 10) return false;
    var digit_count: usize = 0;
    var sum: usize = 0;
    var n: usize = 10;

    for (s, 0..) |c, i| {
        switch (c) {
            '0'...'9' => sum += (c - '0') * n,
            'X' => if (i == s.len - 1) {
                sum += 10 * n;
            } else return false,
            '-' => continue,
            else => return false,
        }
        if (n > 0) n -= 1;
        digit_count += 1;
    }

    return (sum % 11 == 0) and digit_count == 10;
}
