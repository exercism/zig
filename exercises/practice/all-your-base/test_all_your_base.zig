const std = @import("std");
const testing = std.testing;

const all_your_base = @import("all_your_base.zig");
const convert = all_your_base.convert;
const ConversionError = all_your_base.ConversionError;

test "single bit one to decimal" {
    const expected = [_]u32{1};
    const digits = [_]u32{1};
    const input_base = 2;
    const output_base = 10;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "binary to single decimal" {
    const expected = [_]u32{5};
    const digits = [_]u32{ 1, 0, 1 };
    const input_base = 2;
    const output_base = 10;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "single decimal to binary" {
    const expected = [_]u32{ 1, 0, 1 };
    const digits = [_]u32{5};
    const input_base = 10;
    const output_base = 2;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "binary to multiple decimal" {
    const expected = [_]u32{ 4, 2 };
    const digits = [_]u32{ 1, 0, 1, 0, 1, 0 };
    const input_base = 2;
    const output_base = 10;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decimal to binary" {
    const expected = [_]u32{ 1, 0, 1, 0, 1, 0 };
    const digits = [_]u32{ 4, 2 };
    const input_base = 10;
    const output_base = 2;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "trinary to hexadecimal" {
    const expected = [_]u32{ 2, 10 };
    const digits = [_]u32{ 1, 1, 2, 0 };
    const input_base = 3;
    const output_base = 16;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "hexadecimal to trinary" {
    const expected = [_]u32{ 1, 1, 2, 0 };
    const digits = [_]u32{ 2, 10 };
    const input_base = 16;
    const output_base = 3;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "15-bit integer" {
    const expected = [_]u32{ 6, 10, 45 };
    const digits = [_]u32{ 3, 46, 60 };
    const input_base = 97;
    const output_base = 73;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "empty list - second call returns different memory" {
    // The `convert` doc comment says that the caller owns the returned memory.
    // `convert` must always return memory that can be freed.
    // Test that `convert` does not return a slice that references a global array.
    const expected = [_]u32{0};
    const digits = [_]u32{};
    const input_base = 10;
    const output_base = 2;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
    actual[0] = 1; // Modify the output!
    const again = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(again);
    try testing.expectEqualSlices(u32, &expected, again);
}

test "empty list" {
    const expected = [_]u32{0};
    const digits = [_]u32{};
    const input_base = 2;
    const output_base = 10;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "single zero" {
    const expected = [_]u32{0};
    const digits = [_]u32{0};
    const input_base = 10;
    const output_base = 2;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "multiple zeros" {
    const expected = [_]u32{0};
    const digits = [_]u32{ 0, 0, 0 };
    const input_base = 10;
    const output_base = 2;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "leading zeros" {
    const expected = [_]u32{ 4, 2 };
    const digits = [_]u32{ 0, 6, 0 };
    const input_base = 7;
    const output_base = 10;
    const actual = try convert(testing.allocator, &digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "input base is one" {
    const expected = ConversionError.InvalidInputBase;
    const digits = [_]u32{0};
    const input_base = 1;
    const output_base = 10;
    const actual = convert(testing.allocator, &digits, input_base, output_base);
    try testing.expectError(expected, actual);
}

test "input base is zero" {
    const expected = ConversionError.InvalidInputBase;
    const digits = [_]u32{};
    const input_base = 0;
    const output_base = 10;
    const actual = convert(testing.allocator, &digits, input_base, output_base);
    try testing.expectError(expected, actual);
}

test "invalid positive digit" {
    const expected = ConversionError.InvalidDigit;
    const digits = [_]u32{ 1, 2, 1, 0, 1, 0 };
    const input_base = 2;
    const output_base = 10;
    const actual = convert(testing.allocator, &digits, input_base, output_base);
    try testing.expectError(expected, actual);
}

test "output base is one" {
    const expected = ConversionError.InvalidOutputBase;
    const digits = [_]u32{ 1, 0, 1, 0, 1, 0 };
    const input_base = 2;
    const output_base = 1;
    const actual = convert(testing.allocator, &digits, input_base, output_base);
    try testing.expectError(expected, actual);
}

test "output base is zero" {
    const expected = ConversionError.InvalidOutputBase;
    const digits = [_]u32{7};
    const input_base = 10;
    const output_base = 0;
    const actual = convert(testing.allocator, &digits, input_base, output_base);
    try testing.expectError(expected, actual);
}
