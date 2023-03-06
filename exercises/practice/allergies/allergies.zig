const mem = @import("std").mem;

pub const Allergies = enum(u8) { eggs = 0b00000001, peanuts = 0b00000010, shellfish = 0b00000100, strawberries = 0b00001000, tomatoes = 0b00010000, chocolate = 0b00100000, pollen = 0b01000000, cats = 0b10000000 };

pub fn isAllergicTo(allergies: u8, allergen: Allergen) bool {
    _ = allergies;
    _ = allergen;
    @compileError("please implement the isAllergicTo function");
}

pub fn list(allocator: mem.Allocator, allergies: u8) mem.Allocator.Error![]const Allergen {
    _ = allocator;
    _ = allergies;
    @compileError("please implement the list function");
}
