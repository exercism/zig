const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,

    pub fn in(allergen: Allergen, score: u8) bool {
        _ = allergen;
        _ = score;
        @compileError("please implement the in function");
    }

    pub fn initEnumSet(score: usize) EnumSet(Allergen) {
        _ = score;
        @compileError("please implement the initEnumSet function");
    }
};
