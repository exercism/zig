const std = @import("std");
const testing = std.testing;

const queen_attack = @import("queen_attack.zig");
const QueenError = queen_attack.QueenError;

test "queen with a valid position" {
    const queen = try queen_attack.Queen.init(2, 2);
    try testing.expectEqual(@as(queen_attack.Queen, .{ .x = 2, .y = 2 }), queen);
}

test "queen must have positive row" {
    const queen = queen_attack.Queen.init(-2, 2);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have row on board" {
    const queen = queen_attack.Queen.init(8, 4);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have positive column" {
    const queen = queen_attack.Queen.init(2, -2);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "queen must have column on board" {
    const queen = queen_attack.Queen.init(4, 8);
    try testing.expectError(QueenError.InitializationFailure, queen);
}

test "cannot attack" {
    const white = try queen_attack.Queen.init(2, 4);
    const black = try queen_attack.Queen.init(6, 6);
    try testing.expect(!try white.canAttack(black));
}

test "can attack on same row" {
    const white = try queen_attack.Queen.init(2, 4);
    const black = try queen_attack.Queen.init(2, 6);
    try testing.expect(try white.canAttack(black));
}

test "can attack on same column" {
    const white = try queen_attack.Queen.init(4, 5);
    const black = try queen_attack.Queen.init(2, 5);
    try testing.expect(try white.canAttack(black));
}

test "can attack on first diagonal" {
    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(0, 4);
    try testing.expect(try white.canAttack(black));
}

test "can attack on second diagonal" {
    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(3, 1);
    try testing.expect(try white.canAttack(black));
}

test "can attack on third diagonal" {
    const white = try queen_attack.Queen.init(2, 2);
    const black = try queen_attack.Queen.init(1, 1);
    try testing.expect(try white.canAttack(black));
}

test "can attack on fourth diagonal" {
    const white = try queen_attack.Queen.init(1, 7);
    const black = try queen_attack.Queen.init(0, 6);
    try testing.expect(try white.canAttack(black));
}

test "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" {
    const white = try queen_attack.Queen.init(4, 1);
    const black = try queen_attack.Queen.init(2, 5);
    try testing.expect(!try white.canAttack(black));
}
