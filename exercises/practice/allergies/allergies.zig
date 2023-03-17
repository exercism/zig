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
};

pub fn Allergens(score: u64) EnumSet(Allergen) {
    _ = score;
    @compileError("please implement the Allergens function");
}
