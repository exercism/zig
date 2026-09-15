const std = @import("std");
const testing = std.testing;

const dnd_character = @import("dnd_character.zig");
const Character = dnd_character.Character;

fn isValidAbilityScore(n: isize) bool {
    return n >= 3 and n <= 18;
}

fn isValid(c: Character) bool {
    return isValidAbilityScore(c.strength) and
        isValidAbilityScore(c.dexterity) and
        isValidAbilityScore(c.constitution) and
        isValidAbilityScore(c.intelligence) and
        isValidAbilityScore(c.wisdom) and
        isValidAbilityScore(c.charisma) and
        (c.hitpoints == 10 + dnd_character.modifier(c.constitution));
}

fn abilityScores(c: Character) [6]u8 {
    return .{ c.strength, c.dexterity, c.constitution, c.intelligence, c.wisdom, c.charisma };
}

/// The number of times each score from 3 to 18 arises among the
/// 6 * 6 * 6 * 6 = 1296 equally likely rolls of four dice.
const score_weights = [16]u64{ 1, 4, 10, 21, 38, 62, 91, 122, 148, 167, 172, 160, 131, 94, 54, 21 };

/// The number of times each pattern of odd (1) and even (0) scores arises
/// among the 1296 ^ 6 equally likely ways of rolling a character's six abilities.
const parity_weights = blk: {
    var odd: u64 = 0;
    var even: u64 = 0;
    for (score_weights, 3..) |weight, score| {
        if (score % 2 == 1) odd += weight else even += weight;
    }
    var weights: [64]u64 = undefined;
    for (&weights, 0..) |*weight, pattern| {
        const odd_count = @popCount(@as(u6, @intCast(pattern)));
        weight.* = std.math.pow(u64, odd, odd_count) * std.math.pow(u64, even, 6 - odd_count);
    }
    break :blk weights;
};

/// Number of samples in each statistical test.
const sample_size = 100 * 1296;

/// Upper critical values of the chi-squared distribution at p = 0.0001,
/// for 16 - 1 and 64 - 1 degrees of freedom.
const critical_value_15: f64 = 44.2633;
const critical_value_63: f64 = 113.505;

/// Pearson's chi-squared statistic for the observed `counts`, when the
/// expected counts are proportional to `weights`.
fn chiSquared(counts: []const u64, weights: []const u64) f64 {
    var total_count: u64 = 0;
    for (counts) |count| total_count += count;
    var total_weight: u64 = 0;
    for (weights) |weight| total_weight += weight;
    var statistic: f64 = 0;
    for (counts, weights) |count, weight| {
        const expected = @as(f64, @floatFromInt(total_count)) * @as(f64, @floatFromInt(weight)) / @as(f64, @floatFromInt(total_weight));
        const difference = @as(f64, @floatFromInt(count)) - expected;
        statistic += difference * difference / expected;
    }
    return statistic;
}

test "ability modifier for score 3 is -4" {
    const expected: i8 = -4;
    const actual = dnd_character.modifier(3);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 4 is -3" {
    const expected: i8 = -3;
    const actual = dnd_character.modifier(4);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 5 is -3" {
    const expected: i8 = -3;
    const actual = dnd_character.modifier(5);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 6 is -2" {
    const expected: i8 = -2;
    const actual = dnd_character.modifier(6);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 7 is -2" {
    const expected: i8 = -2;
    const actual = dnd_character.modifier(7);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 8 is -1" {
    const expected: i8 = -1;
    const actual = dnd_character.modifier(8);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 9 is -1" {
    const expected: i8 = -1;
    const actual = dnd_character.modifier(9);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 10 is 0" {
    const expected: i8 = 0;
    const actual = dnd_character.modifier(10);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 11 is 0" {
    const expected: i8 = 0;
    const actual = dnd_character.modifier(11);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 12 is +1" {
    const expected: i8 = 1;
    const actual = dnd_character.modifier(12);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 13 is +1" {
    const expected: i8 = 1;
    const actual = dnd_character.modifier(13);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 14 is +2" {
    const expected: i8 = 2;
    const actual = dnd_character.modifier(14);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 15 is +2" {
    const expected: i8 = 2;
    const actual = dnd_character.modifier(15);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 16 is +3" {
    const expected: i8 = 3;
    const actual = dnd_character.modifier(16);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 17 is +3" {
    const expected: i8 = 3;
    const actual = dnd_character.modifier(17);
    try testing.expectEqual(expected, actual);
}

test "ability modifier for score 18 is +4" {
    const expected: i8 = 4;
    const actual = dnd_character.modifier(18);
    try testing.expectEqual(expected, actual);
}

test "random ability is within range" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    const random = prng.random();
    for (0..20) |_| {
        const actual = dnd_character.ability(random);
        try testing.expect(isValidAbilityScore(actual));
    }
}

test "random ability is distributed correctly" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    const random = prng.random();
    var counts = [_]u64{0} ** 16;
    for (0..sample_size) |_| {
        const score = dnd_character.ability(random);
        try testing.expect(isValidAbilityScore(score));
        counts[score - 3] += 1;
    }
    try testing.expect(chiSquared(&counts, &score_weights) < critical_value_15);
}

test "random character is valid" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    const random = prng.random();
    for (0..20) |_| {
        const character = Character.init(random);
        try testing.expect(isValid(character));
    }
}

test "each character ability is distributed correctly" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    const random = prng.random();
    var counts = [_][16]u64{[_]u64{0} ** 16} ** 6;
    for (0..sample_size) |_| {
        const character = Character.init(random);
        for (abilityScores(character), &counts) |score, *ability_counts| {
            try testing.expect(isValidAbilityScore(score));
            ability_counts[score - 3] += 1;
        }
    }
    for (counts) |ability_counts| {
        try testing.expect(chiSquared(&ability_counts, &score_weights) < critical_value_15);
    }
}

test "character abilities are independent" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    const random = prng.random();
    var counts = [_]u64{0} ** 64;
    for (0..sample_size) |_| {
        const character = Character.init(random);
        var pattern: usize = 0;
        for (abilityScores(character)) |score| {
            pattern = 2 * pattern + score % 2;
        }
        counts[pattern] += 1;
    }
    try testing.expect(chiSquared(&counts, &parity_weights) < critical_value_63);
}

test "character depends only on the random number generator" {
    var prng = std.Random.DefaultPrng.init(testing.random_seed);
    var other_prng = std.Random.DefaultPrng.init(testing.random_seed);
    for (0..20) |_| {
        const character = Character.init(prng.random());
        const other_character = Character.init(other_prng.random());
        try testing.expectEqual(character, other_character);
    }
}
