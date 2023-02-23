const std = @import("std");
const math = std.math;
const rand = std.rand;

pub const Character = struct {
    const Self = @This();

    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Self {
        const constitution = ability();
        return Self{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };
    }
};

pub fn modifier(n: i8) i8 {
    return @divFloor(n - 10, 2);
}

var prng = rand.DefaultPrng.init(42);
const random = prng.random();

pub fn ability() i8 {
    var lowest: i8 = math.maxInt(i8);
    var i: u8 = 0;
    var result: i8 = 0;
    while (i < 4) : (i += 1) {
        const roll = random.intRangeAtMost(i8, 1, 6);
        result += roll;
        lowest = @min(lowest, roll);
    }
    result -= lowest;
    return result;
}
