const std = @import("std");
const testing = std.testing;

const saddle_points = @import("saddle_points.zig");
const saddlePoints = saddle_points.saddlePoints;
const Point = saddle_points.Point;

test "Can identify single saddle point" {
    const matrix = [3][3]i32{
        [3]i32{ 9, 8, 7 }, //
        [3]i32{ 5, 3, 2 }, //
        [3]i32{ 6, 6, 7 }, //
    };
    const expected = [_]Point{
        .{ .row = 2, .column = 1 }, //
    };
    const actual = try saddlePoints(3, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify that empty matrix has no saddle points" {
    const matrix = [1][0]i32{
        [0]i32{}, //
    };
    const expected = [_]Point{};
    const actual = try saddlePoints(1, 0, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify lack of saddle points when there are none" {
    const matrix = [3][3]i32{
        [3]i32{ 1, 2, 3 }, //
        [3]i32{ 3, 1, 2 }, //
        [3]i32{ 2, 3, 1 }, //
    };
    const expected = [_]Point{};
    const actual = try saddlePoints(3, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify multiple saddle points in a column" {
    const matrix = [3][3]i32{
        [3]i32{ 4, 5, 4 }, //
        [3]i32{ 3, 5, 5 }, //
        [3]i32{ 1, 5, 4 }, //
    };
    const expected = [_]Point{
        .{ .row = 1, .column = 2 }, //
        .{ .row = 2, .column = 2 }, //
        .{ .row = 3, .column = 2 }, //
    };
    const actual = try saddlePoints(3, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify multiple saddle points in a row" {
    const matrix = [3][3]i32{
        [3]i32{ 6, 7, 8 }, //
        [3]i32{ 5, 5, 5 }, //
        [3]i32{ 7, 5, 6 }, //
    };
    const expected = [_]Point{
        .{ .row = 2, .column = 1 }, //
        .{ .row = 2, .column = 2 }, //
        .{ .row = 2, .column = 3 }, //
    };
    const actual = try saddlePoints(3, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify saddle point in bottom right corner" {
    const matrix = [3][3]i32{
        [3]i32{ 8, 7, 9 }, //
        [3]i32{ 6, 7, 6 }, //
        [3]i32{ 3, 2, 5 }, //
    };
    const expected = [_]Point{
        .{ .row = 3, .column = 3 }, //
    };
    const actual = try saddlePoints(3, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify saddle points in a non square matrix" {
    const matrix = [2][3]i32{
        [3]i32{ 3, 1, 3 }, //
        [3]i32{ 3, 2, 4 }, //
    };
    const expected = [_]Point{
        .{ .row = 1, .column = 1 }, //
        .{ .row = 1, .column = 3 }, //
    };
    const actual = try saddlePoints(2, 3, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify that saddle points in a single column matrix are those with the minimum value" {
    const matrix = [4][1]i32{
        [1]i32{2}, //
        [1]i32{1}, //
        [1]i32{4}, //
        [1]i32{1}, //
    };
    const expected = [_]Point{
        .{ .row = 2, .column = 1 }, //
        .{ .row = 4, .column = 1 }, //
    };
    const actual = try saddlePoints(4, 1, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}

test "Can identify that saddle points in a single row matrix are those with the maximum value" {
    const matrix = [1][4]i32{
        [4]i32{ 2, 5, 3, 5 }, //
    };
    const expected = [_]Point{
        .{ .row = 1, .column = 2 }, //
        .{ .row = 1, .column = 4 }, //
    };
    const actual = try saddlePoints(1, 4, testing.allocator, matrix);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(Point, &expected, actual);
}
