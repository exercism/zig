const std = @import("std");
const mem = std.mem;

fn free(allocator: mem.Allocator, array_list: *std.ArrayList([]u8)) void {
    for (array_list.items) |item| {
        allocator.free(item);
    }
    array_list.deinit(allocator);
}

pub fn transpose(allocator: mem.Allocator, lines: []const []const u8) mem.Allocator.Error![][]u8 {
    var longest: usize = 0;
    for (lines) |line| {
        if (longest < line.len) {
            longest = line.len;
        }
    }

    var array_list = try std.ArrayList([]u8).initCapacity(allocator, longest);
    errdefer free(allocator, &array_list);
    for (0..longest) |i| {
        var line = try std.ArrayList(u8).initCapacity(allocator, lines.len);
        defer line.deinit(allocator);
        for (0..lines.len) |j| {
            if (lines[j].len <= i) {
                continue;
            }

            while (line.items.len < j) {
                line.appendAssumeCapacity(' ');
            }
            line.appendAssumeCapacity(lines[j][i]);
        }
        array_list.appendAssumeCapacity(try line.toOwnedSlice(allocator));
    }
    return array_list.toOwnedSlice(allocator);
}
