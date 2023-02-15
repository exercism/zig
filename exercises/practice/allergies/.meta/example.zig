const EnumSet = @import("std").EnumSet;

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

    pub fn list(score: u64) EnumSet(Self) {
        var result = EnumSet(Self).initEmpty();
        inline for (@typeInfo(Self).Enum.fields) |field| {
            const allergen = @intToEnum(Allergen, field.value);
            if (score & field.value != 0) result.insert(allergen);
        }
        return result;
    }
};
