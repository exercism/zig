const std = @import("std");
const testing = std.testing;

const triangle = @import("triangle.zig");

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "equilateral all sides are equal" {
    const actual = try triangle.Triangle.init(2, 2, 2);
    try testing.expect(actual.isEquilateral());
}

test "equilateral any side is unequal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(2, 3, 2);
    try testing.expect(!actual.isEquilateral());
}

test "equilateral no sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(5, 4, 6);
    try testing.expect(!actual.isEquilateral());
}

test "equilateral all zero sides is not a triangle" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = triangle.Triangle.init(0, 0, 0);
    try testing.expectError(triangle.TriangleError.Degenerate, actual);
}

test "equilateral sides may be floats" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(0.5, 0.5, 0.5);
    try testing.expect(actual.isEquilateral());
}

test "isosceles last two sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(3, 4, 4);
    try testing.expect(actual.isIsosceles());
}

test "isosceles first two sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 4, 3);
    try testing.expect(actual.isIsosceles());
}

test "isosceles first and last sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 3, 4);
    try testing.expect(actual.isIsosceles());
}

test "equilateral triangles are also isosceles" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 3, 4);
    try testing.expect(actual.isIsosceles());
}

test "isosceles no sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(2, 3, 4);
    try testing.expect(!actual.isIsosceles());
}

test "isosceles first triangle inequality violation" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = triangle.Triangle.init(1, 1, 3);
    try testing.expectError(triangle.TriangleError.InvalidInequality, actual);
}

test "isosceles second triangle inequality violation" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = triangle.Triangle.init(1, 3, 1);
    try testing.expectError(triangle.TriangleError.InvalidInequality, actual);
}

test "isosceles third triangle inequality violation" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = triangle.Triangle.init(3, 1, 1);
    try testing.expectError(triangle.TriangleError.InvalidInequality, actual);
}

test "isosceles sides may be floats" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(0.5, 0.4, 0.5);
    try testing.expect(actual.isIsosceles());
}

test "scalene no sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(5, 4, 6);
    try testing.expect(actual.isScalene());
}

test "scalene all sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 4, 4);
    try testing.expect(!actual.isScalene());
}

test "scalene first and second sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 4, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene first and third sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(3, 4, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene second and third sides are equal" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(4, 3, 3);
    try testing.expect(!actual.isScalene());
}

test "scalene may not violate triangle inequality" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = triangle.Triangle.init(7, 3, 2);
    try testing.expectError(triangle.TriangleError.InvalidInequality, actual);
}

test "scalene sides may be floats" {
    // Delete or comment out below line to run test
    try skipTest();

    const actual = try triangle.Triangle.init(0.5, 0.4, 0.6);
    try testing.expect(actual.isScalene());
}
