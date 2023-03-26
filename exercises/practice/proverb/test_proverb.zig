const std = @import("std");
const testing = std.testing;

const proverb = @import("proverb.zig");

test "zero pieces" {
    const input = [_][]const u8{};

    const expected = &input;

    const actual = try proverb.recite(testing.allocator, &input);

    try testing.expectEqualSlices([]const u8, expected, actual);

    // The free here doesn't actually free memory since a zero sized heap
    // allocation doesn't actually point to anything important. So the free
    // method on the allocator just quickly exits if what it points to has
    // has a byte length of zero.
    testing.allocator.free(actual);
}

test "one piece" {
    const input1 = "nail".*;
    const input = [_][]const u8{&input1};

    const expected1 = "And all for the want of a nail.\n".*;
    const expected = [_][]const u8{&expected1};

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "two pieces" {
    const input1 = "nail".*;
    const input2 = "shoe".*;
    const input = [_][]const u8{ &input1, &input2 };

    const expected1 = "For want of a nail the shoe was lost.\n".*;
    const expected2 = "And all for the want of a nail.\n".*;
    const expected = [_][]const u8{ &expected1, &expected2 };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "three pieces" {
    const input1 = "nail".*;
    const input2 = "shoe".*;
    const input3 = "horse".*;
    const input = [_][]const u8{ &input1, &input2, &input3 };

    const expected1 = "For want of a nail the shoe was lost.\n".*;
    const expected2 = "For want of a shoe the horse was lost.\n".*;
    const expected3 = "And all for the want of a nail.\n".*;
    const expected = [_][]const u8{ &expected1, &expected2, &expected3 };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "full proverb" {
    const input1 = "nail".*;
    const input2 = "shoe".*;
    const input3 = "horse".*;
    const input4 = "rider".*;
    const input5 = "message".*;
    const input6 = "battle".*;
    const input7 = "kingdom".*;
    const input = [_][]const u8{ &input1, &input2, &input3, &input4, &input5, &input6, &input7 };

    const expected1 = "For want of a nail the shoe was lost.\n".*;
    const expected2 = "For want of a shoe the horse was lost.\n".*;
    const expected3 = "For want of a horse the rider was lost.\n".*;
    const expected4 = "For want of a rider the message was lost.\n".*;
    const expected5 = "For want of a message the battle was lost.\n".*;
    const expected6 = "For want of a battle the kingdom was lost.\n".*;
    const expected7 = "And all for the want of a nail.\n".*;
    const expected = [_][]const u8{ &expected1, &expected2, &expected3, &expected4, &expected5, &expected6, &expected7 };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "four pieces modernized" {
    const input1 = "pin".*;
    const input2 = "gun".*;
    const input3 = "soldier".*;
    const input4 = "battle".*;
    const input = [_][]const u8{ &input1, &input2, &input3, &input4 };

    const expected1 = "For want of a pin the gun was lost.\n".*;
    const expected2 = "For want of a gun the soldier was lost.\n".*;
    const expected3 = "For want of a soldier the battle was lost.\n".*;
    const expected4 = "And all for the want of a pin.\n".*;
    const expected = [_][]const u8{ &expected1, &expected2, &expected3, &expected4 };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}
