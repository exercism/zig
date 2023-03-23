const std = @import("std");
const testing = std.testing;

const allergies = @import("allergies.zig");
const isAllergicTo = allergies.isAllergicTo;
const initAllergenSet = allergies.initAllergenSet;

test "eggs: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .eggs));
}

test "eggs: allergic only to eggs" {
    try testing.expect(isAllergicTo(1, .eggs));
}

test "eggs: allergic to eggs and something else" {
    try testing.expect(isAllergicTo(3, .eggs));
}

test "eggs: allergic to something, but not eggs" {
    try testing.expect(!isAllergicTo(2, .eggs));
}

test "eggs: allergic to everything" {
    try testing.expect(isAllergicTo(255, .eggs));
}

test "peanuts: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .peanuts));
}

test "peanuts: allergic only to peanuts" {
    try testing.expect(isAllergicTo(2, .peanuts));
}

test "peanuts: allergic to peanuts and something else" {
    try testing.expect(isAllergicTo(7, .peanuts));
}

test "peanuts: allergic to something, but not peanuts" {
    try testing.expect(!isAllergicTo(5, .peanuts));
}

test "peanuts: allergic to everything" {
    try testing.expect(isAllergicTo(255, .peanuts));
}

test "shellfish: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .shellfish));
}

test "shellfish: allergic only to shellfish" {
    try testing.expect(isAllergicTo(4, .shellfish));
}

test "shellfish: allergic to shellfish and something else" {
    try testing.expect(isAllergicTo(14, .shellfish));
}

test "shellfish: allergic to something, but not shellfish" {
    try testing.expect(!isAllergicTo(10, .shellfish));
}

test "shellfish: allergic to everything" {
    try testing.expect(isAllergicTo(255, .shellfish));
}

test "strawberries: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .strawberries));
}

test "strawberries: allergic only to strawberries" {
    try testing.expect(isAllergicTo(8, .strawberries));
}

test "strawberries: allergic to strawberries and something else" {
    try testing.expect(isAllergicTo(28, .strawberries));
}

test "strawberries: allergic to something, but not strawberries" {
    try testing.expect(!isAllergicTo(20, .strawberries));
}

test "strawberries: allergic to everything" {
    try testing.expect(isAllergicTo(255, .strawberries));
}

test "tomatoes: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .tomatoes));
}

test "tomatoes: allergic only to tomatoes" {
    try testing.expect(isAllergicTo(16, .tomatoes));
}

test "tomatoes: allergic to tomatoes and something else" {
    try testing.expect(isAllergicTo(56, .tomatoes));
}

test "tomatoes: allergic to something, but not tomatoes" {
    try testing.expect(!isAllergicTo(40, .tomatoes));
}

test "tomatoes: allergic to everything" {
    try testing.expect(isAllergicTo(255, .tomatoes));
}

test "chocolate: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .chocolate));
}

test "chocolate: allergic only to chocolate" {
    try testing.expect(isAllergicTo(32, .chocolate));
}

test "chocolate: allergic to chocolate and something else" {
    try testing.expect(isAllergicTo(112, .chocolate));
}

test "chocolate: allergic to something, but not chocolate" {
    try testing.expect(!isAllergicTo(80, .chocolate));
}

test "chocolate: allergic to everything" {
    try testing.expect(isAllergicTo(255, .chocolate));
}

test "pollen: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .pollen));
}

test "pollen: allergic only to pollen" {
    try testing.expect(isAllergicTo(64, .pollen));
}

test "pollen: allergic to pollen and something else" {
    try testing.expect(isAllergicTo(224, .pollen));
}

test "pollen: allergic to something, but not pollen" {
    try testing.expect(!isAllergicTo(160, .pollen));
}

test "pollen: allergic to everything" {
    try testing.expect(isAllergicTo(255, .pollen));
}

test "cats: not allergic to anything" {
    try testing.expect(!isAllergicTo(0, .cats));
}

test "cats: allergic only to cats" {
    try testing.expect(isAllergicTo(128, .cats));
}

test "cats: allergic to cats and something else" {
    try testing.expect(isAllergicTo(192, .cats));
}

test "cats: allergic to something, but not cats" {
    try testing.expect(!isAllergicTo(64, .cats));
}

test "cats: allergic to everything" {
    try testing.expect(isAllergicTo(255, .cats));
}

test "initAllergenSet: no allergies" {
    const expected_count: usize = 0;
    const actual = initAllergenSet(0);
    try testing.expectEqual(expected_count, actual.count());
}

test "initAllergenSet: just eggs" {
    const expected_count: usize = 1;
    const actual = initAllergenSet(1);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
}

test "initAllergenSet: just peanuts" {
    const expected_count: usize = 1;
    const actual = initAllergenSet(2);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.peanuts));
}

test "initAllergenSet: just strawberries" {
    const expected_count: usize = 1;
    const actual = initAllergenSet(8);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.strawberries));
}

test "initAllergenSet: eggs and peanuts" {
    const expected_count: usize = 2;
    const actual = initAllergenSet(3);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.peanuts));
}

test "initAllergenSet: more than eggs but not peanuts" {
    const expected_count: usize = 2;
    const actual = initAllergenSet(5);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.shellfish));
}

test "initAllergenSet: lots of stuff" {
    const expected_count: usize = 5;
    const actual = initAllergenSet(248);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.strawberries));
    try testing.expect(actual.contains(.tomatoes));
    try testing.expect(actual.contains(.chocolate));
    try testing.expect(actual.contains(.pollen));
    try testing.expect(actual.contains(.cats));
}

test "initAllergenSet: everything" {
    const expected_count: usize = 8;
    const actual = initAllergenSet(255);
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

test "initAllergenSet: no allergen score parts" {
    const expected_count: usize = 7;
    const actual = initAllergenSet(509);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
    try testing.expect(actual.contains(.shellfish));
    try testing.expect(actual.contains(.strawberries));
    try testing.expect(actual.contains(.tomatoes));
    try testing.expect(actual.contains(.chocolate));
    try testing.expect(actual.contains(.pollen));
    try testing.expect(actual.contains(.cats));
}

test "initAllergenSet: no allergen score parts without highest valid score" {
    const expected_count: usize = 1;
    const actual = initAllergenSet(257);
    try testing.expectEqual(expected_count, actual.count());
    try testing.expect(actual.contains(.eggs));
}
