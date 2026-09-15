const std = @import("std");

pub fn modifier(score: u8) i8 {
    _ = score;
    @compileError("please implement the modifier function");
}

pub fn ability(random: std.Random) u8 {
    _ = random;
    @compileError("please implement the ability function");
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
        _ = random;
        @compileError("please implement the init method");
    }
};
