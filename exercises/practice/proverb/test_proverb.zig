const std = @import("std");
const testing = std.testing;

const proverb = @import("proverb.zig");

fn free(slices: [][]u8) void {
    for (slices) |s| {
        testing.allocator.free(s);
    }
    testing.allocator.free(slices);
}

test "zero pieces" {
    const input = [_][]const u8{};

    const expected = input;

    const actual = try proverb.recite(testing.allocator, &input);

    try testing.expectEqualSlices([]const u8, &expected, actual);

    // The free here doesn't actually free memory since a zero sized heap
    // allocation doesn't actually point to anything important. So the free
    // method on the allocator just quickly exits if what it points to has
    // has a byte length of zero.
    testing.allocator.free(actual);
}

test "one piece" {
    const input = [_][]const u8{
        "nail",
    };

    const expected = [_][]const u8{
        "And all for the want of a nail.\n",
    };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    free(actual);
}

test "two pieces" {
    const input = [_][]const u8{
        "nail",
        "shoe",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "And all for the want of a nail.\n",
    };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    free(actual);
}

test "three pieces" {
    const input = [_][]const u8{
        "nail",
        "shoe",
        "horse",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "For want of a shoe the horse was lost.\n",
        "And all for the want of a nail.\n",
    };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    free(actual);
}

test "full proverb" {
    const input = [_][]const u8{
        "nail",
        "shoe",
        "horse",
        "rider",
        "message",
        "battle",
        "kingdom",
    };

    const expected = [_][]const u8{
        "For want of a nail the shoe was lost.\n",
        "For want of a shoe the horse was lost.\n",
        "For want of a horse the rider was lost.\n",
        "For want of a rider the message was lost.\n",
        "For want of a message the battle was lost.\n",
        "For want of a battle the kingdom was lost.\n",
        "And all for the want of a nail.\n",
    };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    free(actual);
}

test "four pieces modernized" {
    const input = [_][]const u8{
        "pin",
        "gun",
        "soldier",
        "battle",
    };

    const expected = [_][]const u8{
        "For want of a pin the gun was lost.\n",
        "For want of a gun the soldier was lost.\n",
        "For want of a soldier the battle was lost.\n",
        "And all for the want of a pin.\n",
    };

    const actual = try proverb.recite(testing.allocator, &input);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    free(actual);
}
