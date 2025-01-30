const std = @import("std");
const testing = std.testing;

const kindergarten_garden = @import("kindergarten_garden.zig");

test "partial garden with single student" {
    const diagram: []const u8 =
        \\RC
        \\GG
    ;
    const expected = .{ .radishes, .clover, .grass, .grass };
    const actual = kindergarten_garden.plants(diagram, "Alice");
    try testing.expectEqual(expected, actual);
}

test "partial garden-different garden with single student" {
    const diagram: []const u8 =
        \\VC
        \\RC
    ;
    const expected = .{ .violets, .clover, .radishes, .clover };
    const actual = kindergarten_garden.plants(diagram, "Alice");
    try testing.expectEqual(expected, actual);
}

test "partial garden with two students" {
    const diagram: []const u8 =
        \\VVCG
        \\VVRC
    ;
    const expected = .{ .clover, .grass, .radishes, .clover };
    const actual = kindergarten_garden.plants(diagram, "Bob");
    try testing.expectEqual(expected, actual);
}

test "partial garden-multiple students for the same garden with three students-second student's garden" {
    const diagram: []const u8 =
        \\VVCCGG
        \\VVCCGG
    ;
    const expected = .{ .clover, .clover, .clover, .clover };
    const actual = kindergarten_garden.plants(diagram, "Bob");
    try testing.expectEqual(expected, actual);
}

test "partial garden-multiple students for the same garden with three students-third student's garden" {
    const diagram: []const u8 =
        \\VVCCGG
        \\VVCCGG
    ;
    const expected = .{ .grass, .grass, .grass, .grass };
    const actual = kindergarten_garden.plants(diagram, "Charlie");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Alice, first student's garden" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .violets, .radishes, .violets, .radishes };
    const actual = kindergarten_garden.plants(diagram, "Alice");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Bob, second student's garden" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .clover, .grass, .clover, .clover };
    const actual = kindergarten_garden.plants(diagram, "Bob");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Charlie" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .violets, .violets, .clover, .grass };
    const actual = kindergarten_garden.plants(diagram, "Charlie");
    try testing.expectEqual(expected, actual);
}

test "full garden-for David" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .radishes, .violets, .clover, .radishes };
    const actual = kindergarten_garden.plants(diagram, "David");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Eve" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .clover, .grass, .radishes, .grass };
    const actual = kindergarten_garden.plants(diagram, "Eve");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Fred" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .grass, .clover, .violets, .clover };
    const actual = kindergarten_garden.plants(diagram, "Fred");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Ginny" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .clover, .grass, .grass, .clover };
    const actual = kindergarten_garden.plants(diagram, "Ginny");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Harriet" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .violets, .radishes, .radishes, .violets };
    const actual = kindergarten_garden.plants(diagram, "Harriet");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Ileana" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .grass, .clover, .violets, .clover };
    const actual = kindergarten_garden.plants(diagram, "Ileana");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Joseph" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .violets, .clover, .violets, .grass };
    const actual = kindergarten_garden.plants(diagram, "Joseph");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Kincaid, second to last student's garden" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .grass, .clover, .clover, .grass };
    const actual = kindergarten_garden.plants(diagram, "Kincaid");
    try testing.expectEqual(expected, actual);
}

test "full garden-for Larry, last student's garden" {
    const diagram: []const u8 =
        \\VRCGVVRVCGGCCGVRGCVCGCGV
        \\VRCCCGCRRGVCGCRVVCVGCGCV
    ;
    const expected = .{ .grass, .violets, .clover, .violets };
    const actual = kindergarten_garden.plants(diagram, "Larry");
    try testing.expectEqual(expected, actual);
}
