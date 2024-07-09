const std = @import("std");
const testing = std.testing;

const largest_series_product = @import("largest_series_product.zig");

test "finds the largest product if span equals length" {
    const expected: u64 = 18;
    const actual = try largest_series_product.largestProduct("29", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 2 with numbers in order" {
    const expected: u64 = 72;
    const actual = try largest_series_product.largestProduct("0123456789", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 2" {
    const expected: u64 = 48;
    const actual = try largest_series_product.largestProduct("576802143", 2);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 3 with numbers in order" {
    const expected: u64 = 504;
    const actual = try largest_series_product.largestProduct("0123456789", 3);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 3" {
    const expected: u64 = 270;
    const actual = try largest_series_product.largestProduct("1027839564", 3);
    try testing.expectEqual(expected, actual);
}

test "can find the largest product of 5 with numbers in order" {
    const expected: u64 = 15120;
    const actual = try largest_series_product.largestProduct("0123456789", 5);
    try testing.expectEqual(expected, actual);
}

test "can get the largest product of a big number" {
    const expected: u64 = 23520;
    const actual = try largest_series_product.largestProduct("73167176531330624919225119674426574742355349194934", 6);
    try testing.expectEqual(expected, actual);
}

test "reports zero if the only digits are zero" {
    const expected: u64 = 0;
    const actual = try largest_series_product.largestProduct("0000", 2);
    try testing.expectEqual(expected, actual);
}

test "reports zero if all spans include zero" {
    const expected: u64 = 0;
    const actual = try largest_series_product.largestProduct("99099", 3);
    try testing.expectEqual(expected, actual);
}

test "rejects span longer than string length" {
    const actual = largest_series_product.largestProduct("123", 4);
    try testing.expectError(largest_series_product.SeriesError.InsufficientDigits, actual);
}

test "reports 1 for empty string and empty product (0 span)" {
    const expected: u64 = 1;
    const actual = try largest_series_product.largestProduct("", 0);
    try testing.expectEqual(expected, actual);
}

test "reports 1 for nonempty string and empty product (0 span)" {
    const expected: u64 = 1;
    const actual = try largest_series_product.largestProduct("123", 0);
    try testing.expectEqual(expected, actual);
}

test "rejects empty string and nonzero span" {
    const actual = largest_series_product.largestProduct("", 1);
    try testing.expectError(largest_series_product.SeriesError.InsufficientDigits, actual);
}

test "rejects invalid character in digits" {
    const actual = largest_series_product.largestProduct("1234a5", 2);
    try testing.expectError(largest_series_product.SeriesError.InvalidCharacter, actual);
}

test "rejects negative span" {
    const actual = largest_series_product.largestProduct("12345", -1);
    try testing.expectError(largest_series_product.SeriesError.NegativeSpan, actual);
}
