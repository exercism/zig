const std = @import("std");
const mem = std.mem;

fn atbash(c: u8) u8 {
    return switch (c) {
        '0'...'9' => c,
        'A'...'Z' => 'a' + 'Z' - c,
        'a'...'z' => 'a' + 'z' - c,
        else => unreachable,
    };
}

pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const group_len = 5;
    var list = std.ArrayList(u8).init(allocator);
    var count: usize = 0;
    for (s) |c| {
        switch (c) {
            '0'...'9', 'A'...'Z', 'a'...'z' => {
                if (count == group_len) {
                    try list.append(' ');
                    count = 0;
                }
                try list.append(atbash(c));
                count += 1;
            },
            else => continue,
        }
    }
    return list.toOwnedSlice();
}

pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var list = std.ArrayList(u8).init(allocator);
    for (s) |c| {
        switch (c) {
            '0'...'9', 'A'...'Z', 'a'...'z' => try list.append(atbash(c)),
            else => continue,
        }
    }
    return list.toOwnedSlice();
}
