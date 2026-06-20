from lib import zstr

USE_MEM = True

HEADER = """fn annotateTest(
    allocator: mem.Allocator,
    expected: []const []const u8,
    garden: []const []const u8,
) anyerror!void {
    const actual = try flower_field.annotate(allocator, garden);
    defer {
        for (actual) |line| allocator.free(line);
        allocator.free(actual);
    }
    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |e, a| {
        try testing.expectEqualStrings(e, a);
    }
}"""


def _rows(rows):
    if not rows:
        return ""
    inner = ", //".join("\n        " + zstr(r) for r in rows)
    return inner + "  //\n    "


def gen_case(case):
    garden = case["input"]["garden"]
    expected = case["expected"]
    return (
        f"    const garden = [_][]const u8{{{_rows(garden)}}};\n"
        f"    const expected = [_][]const u8{{{_rows(expected)}}};\n"
        "    try std.testing.checkAllAllocationFailures(\n"
        "        std.testing.allocator,\n"
        "        annotateTest,\n"
        "        .{ &expected, &garden },\n"
        "    );\n"
    )
