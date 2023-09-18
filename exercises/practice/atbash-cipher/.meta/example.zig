const std = @import("std");
const mem = std.mem;

fn atbash(c: u8) u8 {
    return switch (c) {
        '0'...'9' => c,
        'A'...'Z' => 'a' + 'Z' - c, // Converts to lowercase.
        'a'...'z' => 'a' + 'z' - c,
        else => unreachable,
    };
}

/// Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const group_len = 5;
    var list = std.ArrayList(u8).init(allocator);
    errdefer list.deinit();
    var count: u32 = 0;
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

/// Caller owns the returned memory.
/// Caller guarantees that `s` consists only of digits, lowercase, and spaces.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    // The returned slice is guaranteed to be shorter than `s`.
    var list = try std.ArrayList(u8).initCapacity(allocator, s.len);
    errdefer list.deinit();
    for (s) |c| {
        switch (c) {
            '0'...'9', 'a'...'z' => list.appendAssumeCapacity(atbash(c)),
            ' ' => continue,
            else => unreachable,
        }
    }
    return list.toOwnedSlice();
}