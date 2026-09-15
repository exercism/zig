HEADER = """const Character = dnd_character.Character;

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
}"""


def describe(case, parent):
    # The "ability modifier" group is flattened away; use just the leaf description.
    return case["description"]


def order_key(case):
    # Property tests for the random generators come after all modifier cases.
    if case["property"] in ("ability", "abilityDistribution"):
        return 1
    if case["property"] == "modifier":
        return 0
    return 2


def gen_case(case):
    prop = case["property"]
    if prop == "modifier":
        score = case["input"]["score"]
        expected = case["expected"]
        return (
            f"    const expected: i8 = {expected};\n"
            f"    const actual = dnd_character.modifier({score});\n"
            f"    try testing.expectEqual(expected, actual);\n"
        )
    s = "    var prng = std.Random.DefaultPrng.init(testing.random_seed);\n"
    if prop != "sameSeed":
        s += "    const random = prng.random();\n"
    if prop == "ability":
        return s + (
            "    for (0..20) |_| {\n"
            "        const actual = dnd_character.ability(random);\n"
            "        try testing.expect(isValidAbilityScore(actual));\n"
            "    }\n"
        )
    if prop == "character":
        return s + (
            "    for (0..20) |_| {\n"
            "        const character = Character.init(random);\n"
            "        try testing.expect(isValid(character));\n"
            "    }\n"
        )
    if prop == "abilityDistribution":
        return s + (
            "    var counts = [_]u64{0} ** 16;\n"
            "    for (0..sample_size) |_| {\n"
            "        const score = dnd_character.ability(random);\n"
            "        try testing.expect(isValidAbilityScore(score));\n"
            "        counts[score - 3] += 1;\n"
            "    }\n"
            "    try testing.expect(chiSquared(&counts, &score_weights) < critical_value_15);\n"
        )
    if prop == "characterDistribution":
        return s + (
            "    var counts = [_][16]u64{[_]u64{0} ** 16} ** 6;\n"
            "    for (0..sample_size) |_| {\n"
            "        const character = Character.init(random);\n"
            "        for (abilityScores(character), &counts) |score, *ability_counts| {\n"
            "            try testing.expect(isValidAbilityScore(score));\n"
            "            ability_counts[score - 3] += 1;\n"
            "        }\n"
            "    }\n"
            "    for (counts) |ability_counts| {\n"
            "        try testing.expect(chiSquared(&ability_counts, &score_weights) < critical_value_15);\n"
            "    }\n"
        )
    if prop == "characterParity":
        return s + (
            "    var counts = [_]u64{0} ** 64;\n"
            "    for (0..sample_size) |_| {\n"
            "        const character = Character.init(random);\n"
            "        var pattern: usize = 0;\n"
            "        for (abilityScores(character)) |score| {\n"
            "            pattern = 2 * pattern + score % 2;\n"
            "        }\n"
            "        counts[pattern] += 1;\n"
            "    }\n"
            "    try testing.expect(chiSquared(&counts, &parity_weights) < critical_value_63);\n"
        )
    if prop == "sameSeed":
        return s + (
            "    var other_prng = std.Random.DefaultPrng.init(testing.random_seed);\n"
            "    for (0..20) |_| {\n"
            "        const character = Character.init(prng.random());\n"
            "        const other_character = Character.init(other_prng.random());\n"
            "        try testing.expectEqual(character, other_character);\n"
            "    }\n"
        )
    raise ValueError(f"unknown property: {prop}")
