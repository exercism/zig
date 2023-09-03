const points = [26]u4{
    1, 3, 3, 2, 1, 4, 2, 4,  1,
    8, 5, 1, 3, 1, 1, 3, 10, 1,
    1, 1, 1, 4, 4, 8, 4, 10,
};

pub fn score(s: []const u8) u32 {
    var result: u32 = 0;
    for (s) |c| {
        const i = switch (c) {
            'a'...'z' => c - 'a',
            'A'...'Z' => c - 'A',
            else => unreachable,
        };
        result += points[i];
    }
    return result;
}
