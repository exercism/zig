from lib import zstr, zcomment_list

IMPORT_SELF = False

HEADER = """const rows = @import("diamond.zig").rows;

fn free(slices: [][]u8) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn testRows(allocator: std.mem.Allocator, expected: []const []const u8, letter: u8) !void {
    const actual = try rows(allocator, letter);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (0..expected.len) |i| {
        try testing.expectEqualStrings(expected[i], actual[i]);
    }
}
"""


def gen_case(case):
    letter = case["input"]["letter"]
    expected = case["expected"]
    body = zcomment_list([zstr(row) for row in expected])
    return (
        f"    const expected = [_][]const u8{body};\n"
        f"    try std.testing.checkAllAllocationFailures(\n"
        f"        std.testing.allocator,\n"
        f"        testRows,\n"
        f"        .{{ &expected, '{letter}' }},\n"
        f"    );\n"
    )
