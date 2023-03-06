const std = @import("std");
const testing = std.testing;

const allergies = @import("allergies.zig");

test "not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.eggs));
}

test "allergic only to eggs" {
    try testing.expect(allergies.isAllergicTo(1, allergies.Allergen.eggs));
}

test "allergic to eggs and something else" {
    try testing.expect(allergies.isAllergicTo(3, allergies.Allergen.eggs));
}

test "allergic to something, but not eggs" {
    try testing.expect(!allergies.isAllergicTo(2, allergies.Allergen.eggs));
}

test "allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.eggs));
}

test "peanuts allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.peanuts));
}

test "peanuts allergy - allergic only to peanuts" {
    try testing.expect(allergies.isAllergicTo(2, allergies.Allergen.peanuts));
}

test "peanuts allergy - allergic to peanuts and something else" {
    try testing.expect(allergies.isAllergicTo(7, allergies.Allergen.peanuts));
}

test "peanuts allergy - allergic to something, but not peanuts" {
    try testing.expect(!allergies.isAllergicTo(5, allergies.Allergen.peanuts));
}

test "peanuts allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.peanuts));
}

test "shellfish allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.shellfish));
}

test "shellfish allergy - allergic only to shellfish" {
    try testing.expect(allergies.isAllergicTo(4, allergies.Allergen.shellfish));
}

test "shellfish allergy - allergic to shellfish and something else" {
    try testing.expect(allergies.isAllergicTo(14, allergies.Allergen.shellfish));
}

test "shellfish allergy - allergic to something, but not shellfish" {
    try testing.expect(!allergies.isAllergicTo(10, allergies.Allergen.shellfish));
}

test "shellfish allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.shellfish));
}

test "strawberries allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.strawberries));
}

test "strawberries allergy - allergic only to strawberries" {
    try testing.expect(allergies.isAllergicTo(8, allergies.Allergen.strawberries));
}

test "strawberries allergy - allergic to strawberries and something else" {
    try testing.expect(allergies.isAllergicTo(28, allergies.Allergen.strawberries));
}

test "strawberries allergy - allergic to something, but not strawberries" {
    try testing.expect(!allergies.isAllergicTo(20, allergies.Allergen.strawberries));
}

test "strawberries allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.strawberries));
}

test "tomatoes allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.tomatoes));
}

test "tomatoes allergy - allergic only to tomatoes" {
    try testing.expect(allergies.isAllergicTo(16, allergies.Allergen.tomatoes));
}

test "tomatoes allergy - allergic to tomatoes and something else" {
    try testing.expect(allergies.isAllergicTo(56, allergies.Allergen.tomatoes));
}

test "tomatoes allergy - allergic to something, but not tomatoes" {
    try testing.expect(!allergies.isAllergicTo(40, allergies.Allergen.tomatoes));
}

test "tomatoes allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.tomatoes));
}

test "chocolate allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.chocolate));
}

test "chocolate allergy - allergic only to chocolate" {
    try testing.expect(allergies.isAllergicTo(32, allergies.Allergen.chocolate));
}

test "chocolate allergy - allergic to chocolate and something else" {
    try testing.expect(allergies.isAllergicTo(112, allergies.Allergen.chocolate));
}

test "chocolate allergy - allergic to something, but not chocolate" {
    try testing.expect(!allergies.isAllergicTo(80, allergies.Allergen.chocolate));
}

test "chocolate allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.chocolate));
}

test "pollen allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.pollen));
}

test "pollen allergy - allergic only to pollen" {
    try testing.expect(allergies.isAllergicTo(64, allergies.Allergen.pollen));
}

test "pollen allergy - allergic to pollen and something else" {
    try testing.expect(allergies.isAllergicTo(224, allergies.Allergen.pollen));
}

test "pollen allergy - allergic to something, but not pollen" {
    try testing.expect(!allergies.isAllergicTo(160, allergies.Allergen.pollen));
}

test "pollen allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.pollen));
}

test "cats allergy - not allergic to anything" {
    try testing.expect(!allergies.isAllergicTo(0, allergies.Allergen.cats));
}

test "cats allergy - allergic only to cats" {
    try testing.expect(allergies.isAllergicTo(128, allergies.Allergen.cats));
}

test "cats allergy - allergic to cats and something else" {
    try testing.expect(allergies.isAllergicTo(192, allergies.Allergen.cats));
}

test "cats allergy - allergic to something, but not cats" {
    try testing.expect(!allergies.isAllergicTo(64, allergies.Allergen.cats));
}

test "cats allergy - allergic to everything" {
    try testing.expect(allergies.isAllergicTo(255, allergies.Allergen.cats));
}

test "list - no allergies" {
    const expected = &[_]allergies.Allergen{};
    const actual = try allergies.list(testing.allocator, 0);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - just eggs" {
    const expected = &[_]allergies.Allergen{.eggs};
    const actual = try allergies.list(testing.allocator, 1);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - just peanuts" {
    const expected = &[_]allergies.Allergen{.peanuts};
    const actual = try allergies.list(testing.allocator, 2);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - just strawberries" {
    const expected = &[_]allergies.Allergen{.strawberries};
    const actual = try allergies.list(testing.allocator, 8);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - eggs and peanuts" {
    const expected = &[_]allergies.Allergen{ .eggs, .peanuts };
    const actual = try allergies.list(testing.allocator, 3);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - more than eggs but not peanuts" {
    const expected = &[_]allergies.Allergen{ .eggs, .shellfish };
    const actual = try allergies.list(testing.allocator, 5);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - lots of stuff" {
    const expected = &[_]allergies.Allergen{ .strawberries, .tomatoes, .chocolate, .pollen, .cats };
    const actual = try allergies.list(testing.allocator, 248);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}

test "list - everything" {
    const expected = &[_]allergies.Allergen{ .eggs, .peanuts, .shellfish, .strawberries, .tomatoes, .chocolate, .pollen, .cats };
    const actual = try allergies.list(testing.allocator, 255);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(allergies.Allergen, expected, actual);
}
