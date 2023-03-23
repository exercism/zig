const std = @import("std");
const math = std.math;
const rand = std.rand;

pub const Character = struct {
    const Self = @This();

    strength: u8,
    dexterity: u8,
    constitution: u8,
    intelligence: u8,
    wisdom: u8,
    charisma: u8,
    hitpoints: u8,

    pub fn init() Self {
        const constitution = ability();
        return Self{
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

pub fn modifier(n: u8) i8 {
    return @divFloor(@intCast(i8, n) - 10, 2);
}

var prng = rand.DefaultPrng.init(42);
const random = prng.random();

pub fn ability() u8 {
    var lowest: u8 = math.maxInt(u8);
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
