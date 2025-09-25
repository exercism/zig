const std = @import("std");
const testing = std.testing;

const piecing_it_together = @import("piecing_it_together.zig");
const jigsawData = piecing_it_together.jigsawData;
const PuzzleError = piecing_it_together.PuzzleError;
const Format = piecing_it_together.Format;
const PartialInformation = piecing_it_together.PartialInformation;
const FullInformation = piecing_it_together.FullInformation;

test "1000 pieces puzzle with 1.6 aspect ratio" {
    const puzzle = PartialInformation{
        .pieces = 1000,
        .aspectRatio = 1.6,
    };
    const expected = FullInformation{
        .pieces = 1000,
        .border = 126,
        .inside = 874,
        .rows = 25,
        .columns = 40,
        .aspectRatio = 1.6,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "square puzzle with 32 rows" {
    const puzzle = PartialInformation{
        .rows = 32,
        .format = .square,
    };
    const expected = FullInformation{
        .pieces = 1024,
        .border = 124,
        .inside = 900,
        .rows = 32,
        .columns = 32,
        .aspectRatio = 1.0,
        .format = .square,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "400 pieces square puzzle with only inside pieces and aspect ratio" {
    const puzzle = PartialInformation{
        .inside = 324,
        .aspectRatio = 1.0,
    };
    const expected = FullInformation{
        .pieces = 400,
        .border = 76,
        .inside = 324,
        .rows = 20,
        .columns = 20,
        .aspectRatio = 1.0,
        .format = .square,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "1500 pieces landscape puzzle with 30 rows and 1.6 aspect ratio" {
    const puzzle = PartialInformation{
        .rows = 30,
        .aspectRatio = 1.6666666666666667,
    };
    const expected = FullInformation{
        .pieces = 1500,
        .border = 156,
        .inside = 1344,
        .rows = 30,
        .columns = 50,
        .aspectRatio = 1.6666666666666667,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "300 pieces portrait puzzle with 70 border pieces" {
    const puzzle = PartialInformation{
        .pieces = 300,
        .border = 70,
        .format = .portrait,
    };
    const expected = FullInformation{
        .pieces = 300,
        .border = 70,
        .inside = 230,
        .rows = 25,
        .columns = 12,
        .aspectRatio = 0.48,
        .format = .portrait,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "puzzle with insufficient data" {
    const puzzle = PartialInformation{
        .pieces = 1500,
        .format = .landscape,
    };
    const actual = jigsawData(puzzle);
    try testing.expectError(PuzzleError.InsufficientData, actual);
}

test "puzzle with contradictory data" {
    const puzzle = PartialInformation{
        .rows = 100,
        .columns = 1000,
        .format = .square,
    };
    const actual = jigsawData(puzzle);
    try testing.expectError(PuzzleError.ContradictoryData, actual);
}
