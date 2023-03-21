const std = @import("std");
const EnumSet = std.EnumSet;
const IntegerBitSet = std.bit_set.IntegerBitSet;

pub const Allergen = enum(u8) {
    const Self = @This();
    const tag_type = @typeInfo(Self).Enum.tag_type;

    eggs = 1,
    peanuts = 2,
    shellfish = 4,
    strawberries = 8,
    tomatoes = 16,
    chocolate = 32,
    pollen = 64,
    cats = 128,

    pub fn isAllergicTo(score: tag_type, allergen: Self) bool {
        return score & @enumToInt(allergen) != 0;
    }
};

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    const len = @typeInfo(Allergen).Enum.fields.len;
    const tag_type = @typeInfo(Allergen).Enum.tag_type;
    const bits = IntegerBitSet(len){ .mask = @truncate(tag_type, score) };
    return .{ .bits = bits };
}
