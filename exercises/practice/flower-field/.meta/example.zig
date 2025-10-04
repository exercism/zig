const std = @import("std");
const mem = std.mem;

fn free(allocator: mem.Allocator, array_list: *std.ArrayList([]u8)) void {
    for (array_list.items) |item| {
        allocator.free(item);
    }
    array_list.deinit(allocator);
}

pub fn annotate(allocator: mem.Allocator, garden: []const []const u8) mem.Allocator.Error![][]u8 {
    const height = garden.len;
    var array_list = try std.ArrayList([]u8).initCapacity(allocator, height);
    errdefer free(allocator, &array_list);
    if (height == 0) {
        return array_list.toOwnedSlice(allocator);
    }

    const width = garden[0].len;

    for (0..height) |i| {
        var row = try allocator.alloc(u8, width);
        for (0..width) |j| {
            if (garden[i][j] == '*') {
                row[j] = '*';
            } else {
                var count: u8 = 0;
                for (0..3) |di| {
                    for (0..3) |dj| {
                        const r = i + di;
                        const c = j + dj;
                        if (r >= 1 and c >= 1 and r <= height and c <= width and garden[r - 1][c - 1] == '*') {
                            count += 1;
                        }
                    }
                }

                if (count == 0) {
                    row[j] = ' ';
                } else {
                    row[j] = '0' + count;
                }
            }
        }

        array_list.appendAssumeCapacity(row);
    }

    return array_list.toOwnedSlice(allocator);
}
