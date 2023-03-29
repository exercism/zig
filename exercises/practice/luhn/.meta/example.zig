pub fn isValid(s: []const u8) bool {
    const lookup = [10]u8{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 };
    var sum: usize = 0;
    var n_digits: usize = 0;
    var i = s.len;

    while (i > 0) {
        i -= 1;
        const c = s[i];
        switch (c) {
            '0'...'9' => {
                const digit = c - '0';
                sum += if (n_digits % 2 == 0) digit else lookup[digit];
                n_digits += 1;
            },
            ' ' => continue,
            else => return false,
        }
    }

    return (sum % 10 == 0) and n_digits > 1;
}
