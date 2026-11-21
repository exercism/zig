const std = @import("std");
const testing = std.testing;

const queen_attack = @import("queen_attack.zig");

fn testCreate(row: u3, col: u3) !void {
    const queen = queen_attack.Queen.init(row, col);
    // Allow the fields to have any name, in any order.
    const field_names = @typeInfo(@TypeOf(queen)).@"struct".field_names;
    inline for (field_names) |name| {
        const actual = @field(queen, name);
        try testing.expect(actual == row or actual == col);
    }
}

test "queen has exactly two fields" {
    try testing.expectEqual(2, @typeInfo(queen_attack.Queen).@"struct".field_names.len);
}

test "queen with a valid position" {
    try testCreate(2, 2);
}

test "cannot attack" {
    const white = queen_attack.Queen.init(2, 4);
    const black = queen_attack.Queen.init(6, 6);
    try testing.expect(!white.canAttack(black));
}

test "can attack on same row" {
    const white = queen_attack.Queen.init(2, 4);
    const black = queen_attack.Queen.init(2, 6);
    try testing.expect(white.canAttack(black));
}

test "can attack on same column" {
    const white = queen_attack.Queen.init(4, 5);
    const black = queen_attack.Queen.init(2, 5);
    try testing.expect(white.canAttack(black));
}

test "can attack on first diagonal" {
    const white = queen_attack.Queen.init(2, 2);
    const black = queen_attack.Queen.init(0, 4);
    try testing.expect(white.canAttack(black));
}

test "can attack on second diagonal" {
    const white = queen_attack.Queen.init(2, 2);
    const black = queen_attack.Queen.init(3, 1);
    try testing.expect(white.canAttack(black));
}

test "can attack on third diagonal" {
    const white = queen_attack.Queen.init(2, 2);
    const black = queen_attack.Queen.init(1, 1);
    try testing.expect(white.canAttack(black));
}

test "can attack on fourth diagonal" {
    const white = queen_attack.Queen.init(1, 7);
    const black = queen_attack.Queen.init(0, 6);
    try testing.expect(white.canAttack(black));
}

test "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" {
    const white = queen_attack.Queen.init(4, 1);
    const black = queen_attack.Queen.init(2, 5);
    try testing.expect(!white.canAttack(black));
}
