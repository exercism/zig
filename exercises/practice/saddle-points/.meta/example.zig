const std = @import("std");
const math = std.math;
const mem = std.mem;

pub const Point = struct {
    row: u16,
    column: u16,
};

pub fn saddlePoints(comptime m: usize, comptime n: usize, allocator: mem.Allocator, matrix: [m][n]i32) mem.Allocator.Error![]Point {
    var results = std.array_list.Managed(Point).init(allocator);
    defer results.deinit();

    if (m == 0 or n == 0) {
        return results.toOwnedSlice();
    }

    var tallest = try allocator.alloc(i32, m);
    defer allocator.free(tallest);
    for (0..m) |i| {
        var best: i32 = math.minInt(i32);
        for (0..n) |j| {
            if (best < matrix[i][j]) {
                best = matrix[i][j];
            }
        }
        tallest[i] = best;
    }

    var shortest = try allocator.alloc(i32, n);
    defer allocator.free(shortest);
    for (0..n) |j| {
        var best: i32 = math.maxInt(i32);
        for (0..m) |i| {
            if (best > matrix[i][j]) {
                best = matrix[i][j];
            }
        }
        shortest[j] = best;
    }

    for (0..m) |i| {
        for (0..n) |j| {
            if (matrix[i][j] == tallest[i] and matrix[i][j] == shortest[j]) {
                try results.append(.{
                    .row = @as(u16, @intCast(i + 1)), //
                    .column = @as(u16, @intCast(j + 1)), //
                });
            }
        }
    }
    return results.toOwnedSlice();
}
