const std = @import("std");

fn createLookup() [10]u8 {
    var result: [10]u8 = undefined;
    for (&result, 0..) |*item, i| {
        const d = 2 * @as(u8, @intCast(i));
        item.* = if (d > 9) d - 9 else d;
    }
    return result;
}

pub fn isValid(s: []const u8) bool {
    const lookup = comptime createLookup();
    comptime std.debug.assert(std.mem.eql(u8, &lookup, &[10]u8{ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 }));
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
