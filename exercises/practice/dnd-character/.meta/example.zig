const std = @import("std");

var prng = std.rand.DefaultPrng.init(42);
const random = prng.random();

pub fn ability() u8 {
    var lowest: u8 = std.math.maxInt(u8);
    var i: usize = 0;
    var result: u8 = 0;
    while (i < 4) : (i += 1) {
        const roll = random.intRangeAtMost(u8, 1, 6);
        result += roll;
        lowest = @min(lowest, roll);
    }
    result -= lowest;
    return result;
}

pub fn modifier(score: u8) i8 {
    return @divFloor(@intCast(i8, score) - 10, 2);
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
            .hitpoints = @intCast(u8, 10 + modifier(constitution)),
        };
    }
};
