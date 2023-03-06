const std = @import("std");
const mem = std.mem;
const enums = std.enums;

pub const Allergen = enum(u8) { eggs = 0b00000001, peanuts = 0b00000010, shellfish = 0b00000100, strawberries = 0b00001000, tomatoes = 0b00010000, chocolate = 0b00100000, pollen = 0b01000000, cats = 0b10000000 };

pub fn isAllergicTo(allergies: u8, allergen: Allergen) bool {
    return allergies & @enumToInt(allergen) != 0;
}

pub fn list(allocator: mem.Allocator, allergies: u8) mem.Allocator.Error![]const Allergen {
    var allergens = std.ArrayList(Allergen).init(allocator);
    defer allergens.deinit();

    for (enums.values(Allergen)) |allergen| {
        if (isAllergicTo(allergies, allergen))
            try allergens.append(allergen);
    }

    return allergens.toOwnedSlice();
}
