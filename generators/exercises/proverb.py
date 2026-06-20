from lib import zstr

HEADER = """
fn free(slices: [][]u8) void {
    for (slices) |s| {
        testing.allocator.free(s);
    }
    testing.allocator.free(slices); // No problem when `slices` has zero length.
}

fn reciteTest(allocator: std.mem.Allocator, input: []const []const u8, expected: []const []const u8) anyerror!void {
    const actual = try proverb.recite(allocator, input);
    defer free(actual);

    for (expected, 0..) |expected_slice, i| {
        try testing.expectEqualSlices(u8, expected_slice, actual[i]);
    }
}"""


def _array(values):
    if not values:
        return "[_][]const u8{}"
    body = "".join(f"\n        {zstr(v)}," for v in values)
    return "[_][]const u8{" + body + "\n    }"


def gen_case(case):
    strings = case["input"]["strings"]
    # The recited lines each end with a newline in the expected output.
    expected = [line + "\n" for line in case["expected"]]
    # zig fmt keeps no blank line between two empty one-line arrays (zero pieces).
    sep = "\n\n" if strings else "\n"
    return (
        f"    const input = {_array(strings)};{sep}"
        f"    const expected = {_array(expected)};\n\n"
        "    try std.testing.checkAllAllocationFailures(\n"
        "        std.testing.allocator,\n"
        "        reciteTest,\n"
        "        .{ &input, &expected },\n"
        "    );\n"
    )
