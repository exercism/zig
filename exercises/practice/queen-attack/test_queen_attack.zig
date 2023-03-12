const std = @import("std");
const testing = std.testing;

const queen_attack = @import("queen_attack.zig");
const QueenError = queen_attack.QueenError;

// Adding "return error.SkipZigTest" to the top of each test results in a compiler error
// This wrapper function around error.SkipZigTest appeases the compiler
fn skipTest() !void {
    return error.SkipZigTest;
}

test "queen has exactly two fields" {
    try testing.expectEqual(2, std.meta.fields(queen_attack.Queen).len);
}

test "queen with a valid position" {
    // Delete or comment out below line to run test
    try skipTest();

    const queen = try queen_attack.Queen.init(2, 2);
    // Allow the fields to have any name.
    const fields = std.meta.fields(@TypeOf(queen));
    inline for (fields) |f| {
        const actual = @field(queen, f.name);
        const expected = @as(@TypeOf(actual), 2);
        try testing.expectEqual(expected, actual);
    }
}

test "queen must have positive row" {
    // Delete or comment out below line to run test
    try skipTest();

    const queen = queen_attack.Queen.init(-2, 2);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have row on board" {
    // Delete or comment out below line to run test
    try skipTest();

    const queen = queen_attack.Queen.init(8, 4);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have positive column" {
    // Delete or comment out below line to run test
    try skipTest();

    const queen = queen_attack.Queen.init(2, -2);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have column on board" {
    // Delete or comment out below line to run test
    try skipTest();

    const queen = queen_attack.Queen.init(4, 8);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "cannot attack" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(2, 4);
    const black = try queen_attack.Queen.init(6, 6);
    try testing.expect(!try white.canAttack(black));
}

test "can attack on same row" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(2, 4);
    const black = try queen_attack.Queen.init(2, 6);
    try testing.expect(try white.canAttack(black));
}

test "can attack on same column" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(4, 5);
    const black = try queen_attack.Queen.init(2, 5);
    try testing.expect(try white.canAttack(black));
}

test "can attack on first diagonal" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(0, 4);
    try testing.expect(try white.canAttack(black));
}

test "can attack on second diagonal" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(3, 1);
    try testing.expect(try white.canAttack(black));
}

test "can attack on third diagonal" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(1, 1);
    try testing.expect(try white.canAttack(black));
}

test "can attack on fourth diagonal" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(1, 7);
    const black = try queen_attack.Queen.init(0, 6);
    try testing.expect(try white.canAttack(black));
}

test "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" {
    // Delete or comment out below line to run test
    try skipTest();

    const white = try queen_attack.Queen.init(4, 1);
    const black = try queen_attack.Queen.init(2, 5);
    try testing.expect(!try white.canAttack(black));
}
