const std = @import("std");
const testing = std.testing;

const phone_number = @import("phone_number.zig");

test "cleans the number" {
    const expected: ?[10]u8 = "2234567890".*;
    const actual = phone_number.clean("(223) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "cleans numbers with dots" {
    const expected: ?[10]u8 = "2234567890".*;
    const actual = phone_number.clean("223.456.7890");
    try testing.expectEqual(expected, actual);
}

test "cleans numbers with multiple spaces" {
    const expected: ?[10]u8 = "2234567890".*;
    const actual = phone_number.clean("223 456   7890   ");
    try testing.expectEqual(expected, actual);
}

test "invalid when 9 digits" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("123456789");
    try testing.expectEqual(expected, actual);
}

test "invalid when 11 digits does not start with a 1" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("22234567890");
    try testing.expectEqual(expected, actual);
}

test "valid when 11 digits and starting with 1" {
    const expected: ?[10]u8 = "2234567890".*;
    const actual = phone_number.clean("12234567890");
    try testing.expectEqual(expected, actual);
}

test "valid when 11 digits and starting with 1 even with punctuation" {
    const expected: ?[10]u8 = "2234567890".*;
    const actual = phone_number.clean("+1 (223) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid when more than 11 digits" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("321234567890");
    try testing.expectEqual(expected, actual);
}

test "invalid with letters" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("523-abc-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid with punctuations" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("523-@:!-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if area code starts with 0" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("(023) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if area code starts with 1" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("(123) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if exchange code starts with 0" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("(223) 056-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if exchange code starts with 1" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("(223) 156-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if area code starts with 0 on valid 11-digit number" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("1 (023) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if area code starts with 1 on valid 11-digit number" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("1 (123) 456-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if exchange code starts with 0 on valid 11-digit number" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("1 (223) 056-7890");
    try testing.expectEqual(expected, actual);
}

test "invalid if exchange code starts with 1 on valid 11-digit number" {
    const expected: ?[10]u8 = null;
    const actual = phone_number.clean("1 (223) 156-7890");
    try testing.expectEqual(expected, actual);
}
