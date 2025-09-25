const std = @import("std");
const mem = std.mem;

fn root(parents: []usize, element: usize) usize {
    var current = element;
    var parent = parents[current];
    while (parent != current) {
        const grandparent = parents[parent];
        parents[current] = grandparent;
        current = parent;
        parent = grandparent;
    }
    return current;
}

pub fn canChain(allocator: mem.Allocator, stones: []const [2]u3) mem.Allocator.Error!bool {
    _ = allocator;

    var tally = std.mem.zeroes([8]usize);
    var parents = [8]usize{ 0, 1, 2, 3, 4, 5, 6, 7 };
    for (stones) |stone| {
        tally[stone[0]] += 1;
        tally[stone[1]] += 1;

        const first = root(&parents, stone[0]);
        const second = root(&parents, stone[1]);
        parents[second] = first;
    }

    var roots: usize = 0;
    for (0..8) |i| {
        if ((tally[i] & 1) != 0) {
            return false;
        }
        if (tally[i] != 0 and parents[i] == i) {
            roots += 1;
        }
    }
    return roots <= 1;
}
