const std = @import("std");
const testing = std.testing;

const triangle = @import("triangle.zig");
fn makeTriangle(a: f64, b: f64, c: f64) triangle.TriangleError!triangle.Triangle {
    return triangle.Triangle.init(a, b, c);
}

test "equilateral all sides are equal" {
    const actual = try makeTriangle(2, 2, 2);
    try testing.expect(actual.isEquilateral());
}

test "equilateral any side is unequal" {
    const actual = try makeTriangle(2, 3, 2);
    try testing.expect(!actual.isEquilateral());
}

test "equilateral no sides are equal" {
    const actual = try makeTriangle(5, 4, 6);
    try testing.expect(!actual.isEquilateral());
}

test "equilateral all zero sides is not a triangle" {
    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle(0, 0, 0));
}

test "equilateral sides may be floats" {
    const actual = try makeTriangle(0.5, 0.5, 0.5);
    try testing.expect(actual.isEquilateral());
}

test "isosceles last two sides are equal" {
    const actual = try makeTriangle(3, 4, 4);
    try testing.expect(actual.isIsosceles());
}

test "isosceles first two sides are equal" {
    const actual = try makeTriangle(4, 4, 3);
    try testing.expect(actual.isIsosceles());
}

test "isosceles first and last sides are equal" {
    const actual = try makeTriangle(4, 3, 4);
    try testing.expect(actual.isIsosceles());
}

test "equilateral triangles are also isosceles" {
    const actual = try makeTriangle(4, 4, 4);
    try testing.expect(actual.isIsosceles());
}

test "isosceles no sides are equal" {
    const actual = try makeTriangle(2, 3, 4);
    try testing.expect(!actual.isIsosceles());
}

test "isosceles first triangle inequality violation" {
    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle(1, 1, 3));
}

test "isosceles second triangle inequality violation" {
    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle(1, 3, 1));
}

test "isosceles third triangle inequality violation" {
    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle(3, 1, 1));
}

test "isosceles sides may be floats" {
    const actual = try makeTriangle(0.5, 0.4, 0.5);
    try testing.expect(actual.isIsosceles());
}

test "scalene no sides are equal" {
    const actual = try makeTriangle(5, 4, 6);
    try testing.expect(actual.isScalene());
}

test "scalene all sides are equal" {
    const actual = try makeTriangle(4, 4, 4);
    try testing.expect(!actual.isScalene());
}

test "scalene first and second sides are equal" {
    const actual = try makeTriangle(4, 4, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene first and third sides are equal" {
    const actual = try makeTriangle(3, 4, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene second and third sides are equal" {
    const actual = try makeTriangle(4, 3, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene may not violate triangle inequality" {
    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle(7, 3, 2));
}

test "scalene sides may be floats" {
    const actual = try makeTriangle(0.5, 0.4, 0.6);
    try testing.expect(actual.isScalene());
}
