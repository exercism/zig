const std = @import("std");
const testing = std.testing;

const perfect_numbers = @import("perfect_numbers.zig");
const Classification = perfect_numbers.Classification;
const classify = perfect_numbers.classify;

test "smallest perfect number is classified correctly" {
    const expected = Classification.perfect;
    const actual = try classify(6);
    try testing.expectEqual(expected, actual);
}

test "medium perfect number is classified correctly" {
    const expected = Classification.perfect;
    const actual = try classify(28);
    try testing.expectEqual(expected, actual);
}

test "large perfect number is classified correctly" {
    const expected = Classification.perfect;
    const actual = try classify(33_550_336);
    try testing.expectEqual(expected, actual);
}

test "smallest abundant number is classified correctly" {
    const expected = Classification.abundant;
    const actual = try classify(12);
    try testing.expectEqual(expected, actual);
}

test "medium abundant number is classified correctly" {
    const expected = Classification.abundant;
    const actual = try classify(30);
    try testing.expectEqual(expected, actual);
}

test "large abundant number is classified correctly" {
    const expected = Classification.abundant;
    const actual = try classify(33_550_335);
    try testing.expectEqual(expected, actual);
}

test "smallest prime deficient number is classified correctly" {
    const expected = Classification.deficient;
    const actual = try classify(2);
    try testing.expectEqual(expected, actual);
}

test "smallest non-prime deficient number is classified correctly" {
    const expected = Classification.deficient;
    const actual = try classify(4);
    try testing.expectEqual(expected, actual);
}

test "medium deficient number is classified correctly" {
    const expected = Classification.deficient;
    const actual = try classify(32);
    try testing.expectEqual(expected, actual);
}

test "large deficient number is classified correctly" {
    const expected = Classification.deficient;
    const actual = try classify(33_550_337);
    try testing.expectEqual(expected, actual);
}

test "edge case (no factors other than itself) is classified correctly" {
    const expected = Classification.deficient;
    const actual = try classify(1);
    try testing.expectEqual(expected, actual);
}

test "zero is rejected (as it is not a positive integer)" {
    const expected = perfect_numbers.ClassifyError.IllegalArgument;
    const actual = classify(0);
    try testing.expectError(expected, actual);
}
