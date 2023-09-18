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

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const group_len = 5;
    var list = try std.ArrayList(u8).initCapacity(allocator, s.len + s.len / group_len);
    errdefer list.deinit();
    var count: u32 = 0;
    for (s) |c| {
        switch (c) {
            '0'...'9', 'A'...'Z', 'a'...'z' => {
                if (count == group_len) {
                    list.appendAssumeCapacity(' ');
                    count = 0;
                }
                list.appendAssumeCapacity(atbash(c));
                count += 1;
            },
            else => continue,
        }
    }
    return list.toOwnedSlice();
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
/// Caller guarantees that `s` consists only of digits, lowercase, and spaces.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    // The length of the returned slice is at most the length of `s`.
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
