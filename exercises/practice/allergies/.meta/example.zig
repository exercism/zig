const std = @import("std");
const EnumSet = std.EnumSet;
const IntegerBitSet = std.bit_set.IntegerBitSet;

pub const Allergen = enum(u8) {
    eggs = 1,
    peanuts = 2,
    shellfish = 4,
    strawberries = 8,
    tomatoes = 16,
    chocolate = 32,
    pollen = 64,
    cats = 128,
};

const tag_type = @typeInfo(Allergen).Enum.tag_type;

pub fn isAllergicTo(score: tag_type, allergen: Allergen) bool {
    return score & @intFromEnum(allergen) != 0;
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    const len = @typeInfo(Allergen).Enum.fields.len;
    const bits = IntegerBitSet(len){ .mask = @as(tag_type, @truncate(score)) };
    return .{ .bits = bits };
}
