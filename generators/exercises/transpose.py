from lib import zstr

IMPORT_SELF = False

HEADER = """const transpose = @import("transpose.zig").transpose;

fn free(slices: [][]u8) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn testTranspose(allocator: std.mem.Allocator, expected: []const []const u8, lines: []const []const u8) !void {
    const actual = try transpose(allocator, lines);
    defer free(actual);
    try testing.expectEqual(expected.len, actual.len);
    for (0..expected.len) |i| {
        try testing.expectEqualStrings(expected[i], actual[i]);
    }
}
"""


def _array(name, items):
    if not items:
        return f"    const {name} = [_][]const u8{{}};\n"
    body = f"    const {name} = [_][]const u8{{\n"
    for item in items:
        body += f"        {zstr(item)}, //\n"
    body += "    };\n"
    return body


def gen_case(case):
    lines = case["input"]["lines"]
    expected = case["expected"]
    body = _array("lines", lines)
    body += _array("expected", expected)
    body += "    try std.testing.checkAllAllocationFailures(\n"
    body += "        std.testing.allocator,\n"
    body += "        testTranspose,\n"
    body += "        .{ &expected, &lines },\n"
    body += "    );\n"
    return body
