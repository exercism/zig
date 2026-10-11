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

test "very large landscape" {
    const puzzle = PartialInformation{
        .border = 1216,
        .inside = 86625,
        .format = .landscape,
    };
    const expected = FullInformation{
        .pieces = 87841,
        .border = 1216,
        .inside = 86625,
        .rows = 233,
        .columns = 377,
        .aspectRatio = 1.6180257510729614,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "portrait puzzle with 8 border pieces" {
    const puzzle = PartialInformation{
        .border = 8,
        .format = .portrait,
    };
    const expected = FullInformation{
        .pieces = 8,
        .border = 8,
        .inside = 0,
        .rows = 4,
        .columns = 2,
        .aspectRatio = 0.5,
        .format = .portrait,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "landscape puzzle with 8 border pieces" {
    const puzzle = PartialInformation{
        .border = 8,
        .format = .landscape,
    };
    const expected = FullInformation{
        .pieces = 8,
        .border = 8,
        .inside = 0,
        .rows = 2,
        .columns = 4,
        .aspectRatio = 2.0,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "puzzle with no inside pieces and aspect ratio 5" {
    const puzzle = PartialInformation{
        .inside = 0,
        .aspectRatio = 5.0,
    };
    const expected = FullInformation{
        .pieces = 20,
        .border = 20,
        .inside = 0,
        .rows = 2,
        .columns = 10,
        .aspectRatio = 5.0,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "puzzle with no inside pieces and aspect ratio 0.2" {
    const puzzle = PartialInformation{
        .inside = 0,
        .aspectRatio = 0.2,
    };
    const expected = FullInformation{
        .pieces = 20,
        .border = 20,
        .inside = 0,
        .rows = 10,
        .columns = 2,
        .aspectRatio = 0.2,
        .format = .portrait,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "puzzle with 87 rows and 94/87 aspect ratio" {
    const puzzle = PartialInformation{
        .rows = 87,
        .aspectRatio = 1.0804597701149425,
    };
    const expected = FullInformation{
        .pieces = 8178,
        .border = 358,
        .inside = 7820,
        .rows = 87,
        .columns = 94,
        .aspectRatio = 1.0804597701149425,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "puzzle with 94 columns and 94/87 aspect ratio" {
    const puzzle = PartialInformation{
        .columns = 94,
        .aspectRatio = 1.0804597701149425,
    };
    const expected = FullInformation{
        .pieces = 8178,
        .border = 358,
        .inside = 7820,
        .rows = 87,
        .columns = 94,
        .aspectRatio = 1.0804597701149425,
        .format = .landscape,
    };
    const actual = try jigsawData(puzzle);
    try testing.expectEqual(expected, actual);
}

test "portrait puzzle with no inside pieces and aspect ratio 1" {
    const puzzle = PartialInformation{
        .inside = 0,
        .aspectRatio = 1.0,
        .format = .portrait,
    };
    const actual = jigsawData(puzzle);
    try testing.expectError(PuzzleError.ContradictoryData, actual);
}

test "landscape puzzle with no inside pieces and aspect ratio 1" {
    const puzzle = PartialInformation{
        .inside = 0,
        .aspectRatio = 1.0,
        .format = .landscape,
    };
    const actual = jigsawData(puzzle);
    try testing.expectError(PuzzleError.ContradictoryData, actual);
}
