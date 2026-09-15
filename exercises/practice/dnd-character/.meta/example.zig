const std = @import("std");

pub fn modifier(score: u8) i8 {
    return @divFloor(@as(i8, @intCast(score)) - 10, 2);
}

pub fn ability(random: std.Random) u8 {
    var lowest: u8 = std.math.maxInt(u8);
    var result: u8 = 0;
    for (0..4) |_| {
        const roll = random.intRangeAtMost(u8, 1, 6);
        result += roll;
        lowest = @min(lowest, roll);
    }
    return result - lowest;
}

pub const Character = struct {
    strength: u8,
    dexterity: u8,
    constitution: u8,
    intelligence: u8,
    wisdom: u8,
    charisma: u8,
    hitpoints: u8,

    pub fn init(random: std.Random) Character {
        const constitution = ability(random);
        return .{
            .strength = ability(random),
            .dexterity = ability(random),
            .constitution = constitution,
            .intelligence = ability(random),
            .wisdom = ability(random),
            .charisma = ability(random),
            .hitpoints = @intCast(10 + modifier(constitution)),
        };
    }
};
