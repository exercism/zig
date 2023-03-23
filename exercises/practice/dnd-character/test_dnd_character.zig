const std = @import("std");
const testing = std.testing;

const dnd_character = @import("dnd_character.zig");
const Character = dnd_character.Character;

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

fn isValidAbilityScore(n: isize) bool {
    return n >= 3 and n <= 18;
}

test "random ability is within range" {
    var i: usize = 0;
    while (i < 20) : (i += 1) {
        const actual = dnd_character.ability();
        try testing.expect(isValidAbilityScore(actual));
    }
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

test "random character is valid" {
    var i: usize = 0;
    while (i < 20) : (i += 1) {
        const character = Character.init();
        try testing.expect(isValid(character));
    }
}
