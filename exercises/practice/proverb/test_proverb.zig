const std = @import("std");
const testing = std.testing;

const proverb = @import("proverb.zig");

test "zero pieces" {
    const array_long = [_][]const u8{};
    const input_slice = &array_long;

    const expected = input_slice;

    const actual = try proverb.recite(testing.allocator, input_slice);

    try testing.expectEqualSlices([]const u8, expected, actual);

    // The free here doesn't actually free memory since a zero sized heap
    // allocation doesn't actually point to anything important. So the free
    // method on the allocator just quickly exits if what it points to has
    // has a byte length of zero.
    testing.allocator.free(actual);
}

test "one piece" {
    const first_input = "nail".*;
    const first_slice = &first_input;
    const input_array = [_][]const u8{first_slice};
    const input_slice = &input_array;

    const first_expected = "And all for the want of a nail.\n".*;
    const first_expected_slice = &first_expected;
    const expected_array = [_][]const u8{first_expected_slice};
    const expected = &expected_array;

    const actual = try proverb.recite(testing.allocator, input_slice);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "two pieces" {
    const first_input = "nail".*;
    const first_slice = &first_input;
    const second_input = "shoe".*;
    const second_slice = &second_input;
    const input_array = [_][]const u8{ first_slice, second_slice };
    const input_slice = &input_array;

    const first_expected = "For want of a nail the shoe was lost.\n".*;
    const first_expected_slice = &first_expected;
    const second_expected = "And all for the want of a nail.\n".*;
    const second_expected_slice = &second_expected;
    const expected_array = [_][]const u8{ first_expected_slice, second_expected_slice };
    const expected = &expected_array;

    const actual = try proverb.recite(testing.allocator, input_slice);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "three pieces" {
    const first_input = "nail".*;
    const first_slice = &first_input;
    const second_input = "shoe".*;
    const second_slice = &second_input;
    const third_input = "horse".*;
    const third_slice = &third_input;
    const input_array = [_][]const u8{ first_slice, second_slice, third_slice };
    const input_slice = &input_array;

    const first_expected = "For want of a nail the shoe was lost.\n".*;
    const first_expected_slice = &first_expected;
    const second_expected = "For want of a shoe the horse was lost.\n".*;
    const second_expected_slice = &second_expected;
    const third_expected = "And all for the want of a nail.\n".*;
    const third_expected_slice = &third_expected;
    const expected_array = [_][]const u8{ first_expected_slice, second_expected_slice, third_expected_slice };
    const expected = &expected_array;

    const actual = try proverb.recite(testing.allocator, input_slice);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "full proverb" {
    const first_input = "nail".*;
    const first_slice = &first_input;
    const second_input = "shoe".*;
    const second_slice = &second_input;
    const third_input = "horse".*;
    const third_slice = &third_input;
    const fourth_input = "rider".*;
    const fourth_slice = &fourth_input;
    const fifth_input = "message".*;
    const fifth_slice = &fifth_input;
    const sixth_input = "battle".*;
    const sixth_slice = &sixth_input;
    const seventh_input = "kingdom".*;
    const seventh_slice = &seventh_input;
    const input_array = [_][]const u8{ first_slice, second_slice, third_slice, fourth_slice, fifth_slice, sixth_slice, seventh_slice };
    const input_slice = &input_array;

    const first_expected = "For want of a nail the shoe was lost.\n".*;
    const first_expected_slice = &first_expected;
    const second_expected = "For want of a shoe the horse was lost.\n".*;
    const second_expected_slice = &second_expected;
    const third_expected = "For want of a horse the rider was lost.\n".*;
    const third_expected_slice = &third_expected;
    const fourth_expected = "For want of a rider the message was lost.\n".*;
    const fourth_expected_slice = &fourth_expected;
    const fifth_expected = "For want of a message the battle was lost.\n".*;
    const fifth_expected_slice = &fifth_expected;
    const sixth_expected = "For want of a battle the kingdom was lost.\n".*;
    const sixth_expected_slice = &sixth_expected;
    const seventh_expected = "And all for the want of a nail.\n".*;
    const seventh_expected_slice = &seventh_expected;
    const expected_array = [_][]const u8{ first_expected_slice, second_expected_slice, third_expected_slice, fourth_expected_slice, fifth_expected_slice, sixth_expected_slice, seventh_expected_slice };
    const expected = &expected_array;

    const actual = try proverb.recite(testing.allocator, input_slice);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}

test "four pieces modernized" {
    const first_input = "pin".*;
    const first_slice = &first_input;
    const second_input = "gun".*;
    const second_slice = &second_input;
    const third_input = "soldier".*;
    const third_slice = &third_input;
    const fourth_input = "battle".*;
    const fourth_slice = &fourth_input;
    const input_array = [_][]const u8{ first_slice, second_slice, third_slice, fourth_slice };
    const input_slice = &input_array;

    const first_expected = "For want of a pin the gun was lost.\n".*;
    const first_expected_slice = &first_expected;
    const second_expected = "For want of a gun the soldier was lost.\n".*;
    const second_expected_slice = &second_expected;
    const third_expected = "For want of a soldier the battle was lost.\n".*;
    const third_expected_slice = &third_expected;
    const fourth_expected = "And all for the want of a pin.\n".*;
    const fourth_expected_slice = &fourth_expected;
    const expected_array = [_][]const u8{ first_expected_slice, second_expected_slice, third_expected_slice, fourth_expected_slice };
    const expected = &expected_array;

    const actual = try proverb.recite(testing.allocator, input_slice);

    for (expected) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }

    for (actual) |inner_slice| {
        testing.allocator.free(inner_slice);
    }
    testing.allocator.free(actual);
}
