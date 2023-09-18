const std = @import("std");

pub const Category = enum {
    ones,
    twos,
    threes,
    fours,
    fives,
    sixes,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

const DiceInt = u3;
const Dice = [5]DiceInt;

/// Returns the sum of the items in `dice` that equal `n`.
fn sumOnly(dice: Dice, n: @typeInfo(Category).Enum.tag_type) u32 {
    var result: u32 = 0;
    for (dice) |d| {
        if (d == n) result += n;
    }
    return result;
}

/// Returns a copy of `dice`, sorted in ascending order.
fn sorted(dice: Dice) Dice {
    var d = dice;
    std.mem.sort(DiceInt, &d, {}, std.sort.asc(DiceInt));
    return d;
}

fn sum(dice: Dice) u32 {
    var result: u32 = 0;
    for (dice) |d| result += d;
    return result;
}

fn scoreFullHouse(dice: Dice) u32 {
    const d = sorted(dice);
    const cond =
        (d[0] == d[1] and d[1] == d[2] and d[2] != d[3] and d[3] == d[4]) or
        (d[0] == d[1] and d[1] != d[2] and d[2] == d[3] and d[3] == d[4]);
    return if (cond) sum(d) else 0;
}

fn scoreFourOfAKind(dice: Dice) u32 {
    const d = sorted(dice);
    if (d[1] == d[2] and d[2] == d[3]) {
        if (d[0] == d[1]) return @as(u32, d[0]) * 4;
        if (d[3] == d[4]) return @as(u32, d[1]) * 4;
    }
    return 0;
}

fn scoreStraight(dice: Dice, straight: Dice) u32 {
    const d = sorted(dice);
    return if (std.mem.eql(DiceInt, &d, &straight)) 30 else 0;
}

fn scoreYacht(d: Dice) u32 {
    return if (d[0] == d[1] and d[1] == d[2] and d[2] == d[3] and d[3] == d[4]) 50 else 0;
}

pub fn score(dice: Dice, category: Category) u32 {
    return switch (category) {
        .ones, .twos, .threes, .fours, .fives, .sixes => sumOnly(dice, @intFromEnum(category) + 1),
        .full_house => scoreFullHouse(dice),
        .four_of_a_kind => scoreFourOfAKind(dice),
        .little_straight => scoreStraight(dice, .{ 1, 2, 3, 4, 5 }),
        .big_straight => scoreStraight(dice, .{ 2, 3, 4, 5, 6 }),
        .choice => sum(dice),
        .yacht => scoreYacht(dice),
    };
}
