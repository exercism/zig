pub fn isIsogram(str: []const u8) bool {
    var mask: u32 = 0;
    for (str) |value| {
        switch (value) {
            'a'...'z' => {
                if (mask & @as(u32, 1) << @as(u5, @truncate(value - 'a')) == 0) {
                    mask |= @as(u32, 1) << @as(u5, @truncate(value - 'a'));
                } else {
                    return false;
                }
            },
            'A'...'Z' => {
                if (mask & @as(u32, 1) << @as(u5, @truncate(value - 'A')) == 0) {
                    mask |= @as(u32, 1) << @as(u5, @truncate(value - 'A'));
                } else {
                    return false;
                }
            },
            else => continue,
        }
    }
    return true;
}
