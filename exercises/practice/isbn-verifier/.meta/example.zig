pub fn isValidIsbn10(s: []const u8) bool {
    if (s.len < 10) return false;
    var n: usize = 0;
    var sum: usize = 0;

    for (s) |c, i| {
        switch (c) {
            '0'...'9' => sum += (c - '0') * (10 - n),
            'X' => if (i == s.len - 1) {
                sum += 10 * (10 - n);
            } else return false,
            '-' => continue,
            else => return false,
        }
        n += 1;
    }

    return (sum % 11 == 0) and n == 10;
}
