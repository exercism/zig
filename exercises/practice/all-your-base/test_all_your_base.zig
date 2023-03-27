const std = @import("std");
const testing = std.testing;

const all_your_base = @import("all_your_base.zig");
const rebase = all_your_base.rebase;
const BaseError = all_your_base.BaseError;

test "single bit one to decimal" {
    const expected = [_]usize{1};
    const digits = [_]usize{1};
    const from_base = 2;
    const to_base = 10;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "binary to single decimal" {
    const expected = [_]usize{5};
    const digits = [_]usize{ 1, 0, 1 };
    const from_base = 2;
    const to_base = 10;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "single decimal to binary" {
    const expected = [_]usize{ 1, 0, 1 };
    const digits = [_]usize{5};
    const from_base = 10;
    const to_base = 2;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "binary to multiple decimal" {
    const expected = [_]usize{ 4, 2 };
    const digits = [_]usize{ 1, 0, 1, 0, 1, 0 };
    const from_base = 2;
    const to_base = 10;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "decimal to binary" {
    const expected = [_]usize{ 1, 0, 1, 0, 1, 0 };
    const digits = [_]usize{ 4, 2 };
    const from_base = 10;
    const to_base = 2;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "trinary to hexadecimal" {
    const expected = [_]usize{ 2, 10 };
    const digits = [_]usize{ 1, 1, 2, 0 };
    const from_base = 3;
    const to_base = 16;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "hexadecimal to trinary" {
    const expected = [_]usize{ 1, 1, 2, 0 };
    const digits = [_]usize{ 2, 10 };
    const from_base = 16;
    const to_base = 3;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "15-bit integer" {
    const expected = [_]usize{ 6, 10, 45 };
    const digits = [_]usize{ 3, 46, 60 };
    const from_base = 97;
    const to_base = 73;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "empty list" {
    const expected = [_]usize{0};
    const digits = [_]usize{};
    const from_base = 2;
    const to_base = 10;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "single zero" {
    const expected = [_]usize{0};
    const digits = [_]usize{0};
    const from_base = 10;
    const to_base = 2;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "multiple zeros" {
    const expected = [_]usize{0};
    const digits = [_]usize{ 0, 0, 0 };
    const from_base = 10;
    const to_base = 2;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "leading zeros" {
    const expected = [_]usize{ 4, 2 };
    const digits = [_]usize{ 0, 6, 0 };
    const from_base = 7;
    const to_base = 10;
    const actual = try rebase(testing.allocator, &digits, from_base, to_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(usize, &expected, actual);
}

test "input base is one" {
    const expected = BaseError.InvalidInputBase;
    const digits = [_]usize{0};
    const from_base = 1;
    const to_base = 10;
    const actual = rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectError(expected, actual);
}

test "input base is zero" {
    const expected = BaseError.InvalidInputBase;
    const digits = [_]usize{};
    const from_base = 0;
    const to_base = 10;
    const actual = rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectError(expected, actual);
}

test "invalid positive digit" {
    const expected = BaseError.InvalidDigit;
    const digits = [_]usize{ 1, 2, 1, 0, 1, 0 };
    const from_base = 2;
    const to_base = 10;
    const actual = rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectError(expected, actual);
}

test "output base is one" {
    const expected = BaseError.InvalidOutputBase;
    const digits = [_]usize{ 1, 0, 1, 0, 1, 0 };
    const from_base = 2;
    const to_base = 1;
    const actual = rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectError(expected, actual);
}

test "output base is zero" {
    const expected = BaseError.InvalidOutputBase;
    const digits = [_]usize{7};
    const from_base = 10;
    const to_base = 0;
    const actual = rebase(testing.allocator, &digits, from_base, to_base);
    try testing.expectError(expected, actual);
}
