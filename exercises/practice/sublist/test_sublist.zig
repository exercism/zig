const std = @import("std");
const testing = std.testing;

const sublist = @import("sublist.zig");

test "empty lists" {
    const list_one = &[_]i32{};
    const list_two = &[_]i32{};
    const expected = .equal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "empty list within non empty list" {
    const list_one = &[_]i32{};
    const list_two = &[_]i32{ 1, 2, 3 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "non empty list contains empty list" {
    const list_one = &[_]i32{ 1, 2, 3 };
    const list_two = &[_]i32{};
    const expected = .superlist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "list equals itself" {
    const list_one = &[_]i32{ 1, 2, 3 };
    const list_two = &[_]i32{ 1, 2, 3 };
    const expected = .equal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "different lists" {
    const list_one = &[_]i32{ 1, 2, 3 };
    const list_two = &[_]i32{ 2, 3, 4 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "false start" {
    const list_one = &[_]i32{ 1, 2, 5 };
    const list_two = &[_]i32{ 0, 1, 2, 3, 1, 2, 5, 6 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "consecutive" {
    const list_one = &[_]i32{ 1, 1, 2 };
    const list_two = &[_]i32{ 0, 1, 1, 1, 2, 1, 2 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "sublist at start" {
    const list_one = &[_]i32{ 0, 1, 2 };
    const list_two = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "sublist in middle" {
    const list_one = &[_]i32{ 2, 3, 4 };
    const list_two = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "sublist at end" {
    const list_one = &[_]i32{ 3, 4, 5 };
    const list_two = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const expected = .sublist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "at start of superlist" {
    const list_one = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const list_two = &[_]i32{ 0, 1, 2 };
    const expected = .superlist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "in middle of superlist" {
    const list_one = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const list_two = &[_]i32{ 2, 3 };
    const expected = .superlist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "at end of superlist" {
    const list_one = &[_]i32{ 0, 1, 2, 3, 4, 5 };
    const list_two = &[_]i32{ 3, 4, 5 };
    const expected = .superlist;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "first list missing element from second list" {
    const list_one = &[_]i32{ 1, 3 };
    const list_two = &[_]i32{ 1, 2, 3 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "second list missing element from first list" {
    const list_one = &[_]i32{ 1, 2, 3 };
    const list_two = &[_]i32{ 1, 3 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "first list missing additional digits from second list" {
    const list_one = &[_]i32{ 1, 2 };
    const list_two = &[_]i32{ 1, 22 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "order matters to a list" {
    const list_one = &[_]i32{ 1, 2, 3 };
    const list_two = &[_]i32{ 3, 2, 1 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}

test "same digits but different numbers" {
    const list_one = &[_]i32{ 1, 0, 1 };
    const list_two = &[_]i32{ 10, 1 };
    const expected = .unequal;
    const actual = sublist.compare(list_one, list_two);
    try testing.expectEqual(expected, actual);
}
