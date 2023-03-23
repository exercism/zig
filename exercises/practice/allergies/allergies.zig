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
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    _ = score;
    _ = allergen;
    @compileError("please implement the isAllergicTo function");
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    _ = score;
    @compileError("please implement the initAllergenSet function");
}
