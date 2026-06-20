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
}"""


def describe(case, parent):
    # The "ability modifier" group is flattened away; use just the leaf description.
    return case["description"]


def order_key(case):
    # Property tests for the random generators come after all modifier cases.
    if case["property"] == "ability":
        return 1
    if case["property"] == "character":
        return 2
    return 0


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
    if prop == "ability":
        return (
            "    for (0..20) |_| {\n"
            "        const actual = dnd_character.ability();\n"
            "        try testing.expect(isValidAbilityScore(actual));\n"
            "    }\n"
        )
    # character
    return (
        "    for (0..20) |_| {\n"
        "        const character = Character.init();\n"
        "        try testing.expect(isValid(character));\n"
        "    }\n"
    )
