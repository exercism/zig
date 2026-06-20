from lib import zint

USE_MEM = False

HEADER = """fn free(slices: [][]u128) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn pascalsTriangleTest(allocator: std.mem.Allocator, count: usize, expected: [][]const u128) anyerror!void {
    const actual = try pascals_triangle.rows(allocator, count);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u128, expected_slice, actual_slice);
    }
}
"""


def gen_case(case):
    count = case["input"]["count"]

    # Supplemental single-element check (e.g. the "seventy-five rows" case): rather than
    # build a full expected triangle, assert one cell. Driven by an `expected_element`
    # key carrying {row, column, value}.
    if "expected_element" in case:
        el = case["expected_element"]
        return (
            f"    const actual = try pascals_triangle.rows(testing.allocator, {count});\n"
            "    defer free(actual);\n\n"
            f"    try testing.expectEqual({zint(el['value'])}, actual[{el['row']}][{el['column']}]);\n"
        )

    expected = case["expected"]
    var = "const" if expected == [] else "var"

    out = [f"    {var} expected: [{count}][]const u128 = undefined;\n"]
    for i, row in enumerate(expected):
        slice = "{ " + ", ".join(str(v) for v in row) + " }"
        out.append(f"    expected[{i}] = &.{slice};\n")
    out.append("    try std.testing.checkAllAllocationFailures(\n")
    out.append("        std.testing.allocator,\n")
    out.append("        pascalsTriangleTest,\n")
    out.append(f"        .{{ {count}, &expected }},\n")
    out.append("    );\n")
    return "".join(out)
