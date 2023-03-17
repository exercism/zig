const std = @import("std");
const testing = std.testing;

const allergies = @import("allergies.zig");
const Allergen = allergies.Allergen;
const Allergens = allergies.Allergens;

test "eggs: not allergic to anything" {
    try testing.expect(!Allergen.eggs.in(0));
}

test "eggs: allergic only to eggs" {
    try testing.expect(Allergen.eggs.in(1));
}

test "eggs: allergic to eggs and something else" {
    try testing.expect(Allergen.eggs.in(3));
}

test "eggs: allergic to something, but not eggs" {
    try testing.expect(!Allergen.eggs.in(2));
}

test "eggs: allergic to everything" {
    try testing.expect(Allergen.eggs.in(255));
}

test "peanuts: not allergic to anything" {
    try testing.expect(!Allergen.peanuts.in(0));
}

test "peanuts: allergic only to peanuts" {
    try testing.expect(Allergen.peanuts.in(2));
}

test "peanuts: allergic to peanuts and something else" {
    try testing.expect(Allergen.peanuts.in(7));
}

test "peanuts: allergic to something, but not peanuts" {
    try testing.expect(!Allergen.peanuts.in(5));
}

test "peanuts: allergic to everything" {
    try testing.expect(Allergen.peanuts.in(255));
}

test "shellfish: not allergic to anything" {
    try testing.expect(!Allergen.shellfish.in(0));
}

test "shellfish: allergic only to shellfish" {
    try testing.expect(Allergen.shellfish.in(4));
}

test "shellfish: allergic to shellfish and something else" {
    try testing.expect(Allergen.shellfish.in(14));
}

test "shellfish: allergic to something, but not shellfish" {
    try testing.expect(!Allergen.shellfish.in(10));
}

test "shellfish: allergic to everything" {
    try testing.expect(Allergen.shellfish.in(255));
}

test "strawberries: not allergic to anything" {
    try testing.expect(!Allergen.strawberries.in(0));
}

test "strawberries: allergic only to strawberries" {
    try testing.expect(Allergen.strawberries.in(8));
}

test "strawberries: allergic to strawberries and something else" {
    try testing.expect(Allergen.strawberries.in(28));
}

test "strawberries: allergic to something, but not strawberries" {
    try testing.expect(!Allergen.strawberries.in(20));
}

test "strawberries: allergic to everything" {
    try testing.expect(Allergen.strawberries.in(255));
}

test "tomatoes: not allergic to anything" {
    try testing.expect(!Allergen.tomatoes.in(0));
}

test "tomatoes: allergic only to tomatoes" {
    try testing.expect(Allergen.tomatoes.in(16));
}

test "tomatoes: allergic to tomatoes and something else" {
    try testing.expect(Allergen.tomatoes.in(56));
}

test "tomatoes: allergic to something, but not tomatoes" {
    try testing.expect(!Allergen.tomatoes.in(40));
}

test "tomatoes: allergic to everything" {
    try testing.expect(Allergen.tomatoes.in(255));
}

test "chocolate: not allergic to anything" {
    try testing.expect(!Allergen.chocolate.in(0));
}

test "chocolate: allergic only to chocolate" {
    try testing.expect(Allergen.chocolate.in(32));
}

test "chocolate: allergic to chocolate and something else" {
    try testing.expect(Allergen.chocolate.in(112));
}

test "chocolate: allergic to something, but not chocolate" {
    try testing.expect(!Allergen.chocolate.in(80));
}

test "chocolate: allergic to everything" {
    try testing.expect(Allergen.chocolate.in(255));
}

test "pollen: not allergic to anything" {
    try testing.expect(!Allergen.pollen.in(0));
}

test "pollen: allergic only to pollen" {
    try testing.expect(Allergen.pollen.in(64));
}

test "pollen: allergic to pollen and something else" {
    try testing.expect(Allergen.pollen.in(224));
}

test "pollen: allergic to something, but not pollen" {
    try testing.expect(!Allergen.pollen.in(160));
}

test "pollen: allergic to everything" {
    try testing.expect(Allergen.pollen.in(255));
}

test "cats: not allergic to anything" {
    try testing.expect(!Allergen.cats.in(0));
}

test "cats: allergic only to cats" {
    try testing.expect(Allergen.cats.in(128));
}

test "cats: allergic to cats and something else" {
    try testing.expect(Allergen.cats.in(192));
}

test "cats: allergic to something, but not cats" {
    try testing.expect(!Allergen.cats.in(64));
}

test "cats: allergic to everything" {
    try testing.expect(Allergen.cats.in(255));
}

test "Allergens: no allergies" {
    const expected_count: usize = 0;
    const actual = Allergens(0);
    try testing.expectEqual(expected_count, actual.count());
}

test "Allergens: just eggs" {
    const expected_count: usize = 1;
    const actual = Allergens(1);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
}

test "Allergens: just peanuts" {
    const expected_count: usize = 1;
    const actual = Allergens(2);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.peanuts));
}

test "Allergens: just strawberries" {
    const expected_count: usize = 1;
    const actual = Allergens(8);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.strawberries));
}

test "Allergens: eggs and peanuts" {
    const expected_count: usize = 2;
    const actual = Allergens(3);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.peanuts));
}

test "Allergens: more than eggs but not peanuts" {
    const expected_count: usize = 2;
    const actual = Allergens(5);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.shellfish));
}

test "Allergens: lots of stuff" {
    const expected_count: usize = 5;
    const actual = Allergens(248);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.strawberries));
    try testing.expect(actual.contains(.tomatoes));
    try testing.expect(actual.contains(.chocolate));
    try testing.expect(actual.contains(.pollen));
    try testing.expect(actual.contains(.cats));
}

test "Allergens: everything" {
    const expected_count: usize = 8;
    const actual = Allergens(255);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.peanuts));
    try testing.expect(actual.contains(.shellfish));
    try testing.expect(actual.contains(.strawberries));
    try testing.expect(actual.contains(.tomatoes));
    try testing.expect(actual.contains(.chocolate));
    try testing.expect(actual.contains(.pollen));
    try testing.expect(actual.contains(.cats));
}

test "Allergens: no allergen score parts" {
    const expected_count: usize = 7;
    const actual = Allergens(509);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.shellfish));
    try testing.expect(actual.contains(.strawberries));
    try testing.expect(actual.contains(.tomatoes));
    try testing.expect(actual.contains(.chocolate));
    try testing.expect(actual.contains(.pollen));
    try testing.expect(actual.contains(.cats));
}

test "Allergens: no allergen score parts without highest valid score" {
    const expected_count: usize = 1;
    const actual = Allergens(257);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
}
