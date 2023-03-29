pub fn isValid(s: []const u8) bool {
    const lookup = [10]u8{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 };
    var sum: usize = 0;
    var digit_count: usize = 0;
    var i = s.len;

    while (i > 0) {
        i -= 1;
        const c = s[i];
        switch (c) {
            '0'...'9' => {
                const digit = c - '0';
                sum += if (digit_count % 2 == 0) digit else lookup[digit];
                digit_count += 1;
            },
            ' ' => continue,
            else => return false,
        }
    }

    return (sum % 10 == 0) and digit_count > 1;
}
