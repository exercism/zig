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
        // TODO: With Zig 0.11.0, consider using `EnumSet(Self).initEmpty()`,
        // which was added by https://github.com/ziglang/zig/commit/a792e13fc089
        const fields = @typeInfo(Self).Enum.fields;
        var result = std.EnumSet(Self){ .bits = std.StaticBitSet(fields.len).initEmpty() };
        inline for (fields) |field| {
            const allergen = @intToEnum(Allergen, field.value);
            if (score & field.value != 0) result.insert(allergen);
        }
        return result;
    }
};
