const std = @import("std");
const mem = std.mem;

pub const Item = struct {
    weight: usize,
    value: usize,

    pub fn init(weight: usize, value: usize) Item {
        return Item{
            .weight = weight,
            .value = value,
        };
    }
};

pub fn maximumValue(allocator: mem.Allocator, maximumWeight: usize, items: []const Item) !usize {
    const table = try allocator.alloc(usize, maximumWeight + 1);
    defer allocator.free(table);
    @memset(table, 0);
    for (items, 0..) |item, itemIndex| {
        _ = itemIndex;
        var index = maximumWeight + 1;
        while (index > item.weight) {
            index -= 1;
            const value = item.value + table[index - item.weight];
            if (table[index] < value) {
                table[index] = value;
            }
        }
    }
    return table[maximumWeight];
}
