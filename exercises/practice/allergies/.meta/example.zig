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

    pub fn in(allergen: Self, score: tag_type) bool {
        return score & @enumToInt(allergen) != 0;
    }

    pub fn initEnumSet(score: usize) EnumSet(Self) {
        const len = @typeInfo(Self).Enum.fields.len;
        const bits = IntegerBitSet(len){ .mask = @truncate(tag_type, score) };
        return .{ .bits = bits };
    }
};
