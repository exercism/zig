const std = @import("std");
const mem = std.mem;

pub const Box = union(enum) {
    none,
    one: i12,
    many: []const Box,
};

pub fn flatten(allocator: mem.Allocator, box: Box) mem.Allocator.Error![]i12 {
    var results = std.array_list.Managed(i12).init(allocator);
    defer results.deinit();
    try traverse(allocator, &results, box);
    return results.toOwnedSlice();
}

fn traverse(allocator: mem.Allocator, dest: *std.array_list.Managed(i12), box: Box) mem.Allocator.Error!void {
    switch (box) {
        Box.none => {},
        Box.one => |item| {
            try dest.append(item);
        },
        Box.many => |elements| {
            for (elements) |element| {
                try traverse(allocator, dest, element);
            }
        },
    }
}
