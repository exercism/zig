const std = @import("std");

var prng = std.rand.DefaultPrng.init(42);
const random = prng.random();

pub fn ability() u8 {
    var lowest: u8 = std.math.maxInt(u8);
    var result: u8 = 0;
    for (0..4) |_| {
        const roll = random.intRangeAtMost(u8, 1, 6);
        result += roll;
        lowest = @min(lowest, roll);
    }
    result -= lowest;
    return result;
}

pub fn modifier(score: u8) i8 {
    return @divFloor(@as(i8, @intCast(score)) - 10, 2);
}

pub const Character = struct {
    strength: u8,
    dexterity: u8,
    constitution: u8,
    intelligence: u8,
    wisdom: u8,
    charisma: u8,
    hitpoints: u8,

    pub fn init() Character {
        const constitution = ability();
        return .{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = @as(u8, @intCast(10 + modifier(constitution))),
        };
    }
};
