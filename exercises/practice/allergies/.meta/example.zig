const std = @import("std");

pub const Allergen = enum(u8) {
    const Self = @This();

    eggs = 1,
    peanuts = 2,
    shellfish = 4,
    strawberries = 8,
    tomatoes = 16,
    chocolate = 32,
    pollen = 64,
    cats = 128,

    pub fn in(allergen: Self, score: u8) bool {
        return score & @enumToInt(allergen) != 0;
    }

    pub fn list(score: u64) std.EnumSet(Self) {
        const len = @typeInfo(Self).Enum.fields.len;
        const tag_type = @typeInfo(Self).Enum.tag_type;
        const bits = @bitCast(std.bit_set.IntegerBitSet(len), @truncate(tag_type, score));
        return std.EnumSet(Self){ .bits = bits };
    }
};
