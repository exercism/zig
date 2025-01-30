const std = @import("std");
const testing = std.testing;

const book_store = @import("book_store.zig");

test "Only a single book" {
    const basket = &[_]u32{1};
    try testing.expectEqual(800, book_store.total(basket));
}

test "Two of the same book" {
    const basket = &[_]u32{ 2, 2 };
    try testing.expectEqual(1600, book_store.total(basket));
}

test "Empty basket" {
    const basket = &[_]u32{};
    try testing.expectEqual(0, book_store.total(basket));
}

test "Two different books" {
    const basket = &[_]u32{ 1, 2 };
    try testing.expectEqual(1520, book_store.total(basket));
}

test "Three different books" {
    const basket = &[_]u32{ 1, 2, 3 };
    try testing.expectEqual(2160, book_store.total(basket));
}

test "Four different books" {
    const basket = &[_]u32{ 1, 2, 3, 4 };
    try testing.expectEqual(2560, book_store.total(basket));
}

test "Five different books" {
    const basket = &[_]u32{ 1, 2, 3, 4, 5 };
    try testing.expectEqual(3000, book_store.total(basket));
}

test "Two groups of four is cheaper than group of five plus group of three" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 5 };
    try testing.expectEqual(5120, book_store.total(basket));
}

test "Two groups of four is cheaper than groups of five and three" {
    const basket = &[_]u32{ 1, 1, 2, 3, 4, 4, 5, 5 };
    try testing.expectEqual(5120, book_store.total(basket));
}

test "Group of four plus group of two is cheaper than two groups of three" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 4 };
    try testing.expectEqual(4080, book_store.total(basket));
}

test "Two each of first four books and one copy each of rest" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 4, 5 };
    try testing.expectEqual(5560, book_store.total(basket));
}

test "Two copies of each book" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 };
    try testing.expectEqual(6000, book_store.total(basket));
}

test "Three copies of first book and two each of remaining" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1 };
    try testing.expectEqual(6800, book_store.total(basket));
}

test "Three each of first two books and two each of remaining books" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 2 };
    try testing.expectEqual(7520, book_store.total(basket));
}

test "Four groups of four are cheaper than two groups each of five and three" {
    const basket = &[_]u32{ 1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5 };
    try testing.expectEqual(10240, book_store.total(basket));
}

test "Check that groups of four are created properly even when there are more groups of three than groups of five" {
    const basket = &[_]u32{ 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 5, 5 };
    try testing.expectEqual(14560, book_store.total(basket));
}

test "One group of one and four is cheaper than one group of two and three" {
    const basket = &[_]u32{ 1, 1, 2, 3, 4 };
    try testing.expectEqual(3360, book_store.total(basket));
}

test "One group of one and two plus three groups of four is cheaper than one group of each size" {
    const basket = &[_]u32{ 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5 };
    try testing.expectEqual(10000, book_store.total(basket));
}
