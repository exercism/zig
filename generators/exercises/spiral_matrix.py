IMPORT_SELF = True

HEADER = """const spiral = spiral_matrix.spiral;

fn free(slices: [][]u16) void {
    for (slices) |slice| {
        testing.allocator.free(slice);
    }
    testing.allocator.free(slices);
}

fn spiralTest(allocator: std.mem.Allocator, size: u16, expected: [][]const u16) anyerror!void {
    const actual = try spiral(allocator, size);
    defer free(actual);

    try testing.expectEqual(expected.len, actual.len);
    for (expected, actual) |expected_slice, actual_slice| {
        try testing.expectEqualSlices(u16, expected_slice, actual_slice);
    }
}
"""


def gen_case(case):
    size = case["input"]["size"]
    rows = case["expected"]
    count = len(rows)
    if count == 0:
        body = "    const expected: [0][]const u16 = undefined;\n"
    else:
        body = f"    var expected: [{count}][]const u16 = undefined;\n"
        for i, row in enumerate(rows):
            inner = ", ".join(str(v) for v in row)
            body += f"    expected[{i}] = &.{{{inner}}};\n"
    body += "    try testing.checkAllAllocationFailures(\n"
    body += "        testing.allocator,\n"
    body += "        spiralTest,\n"
    body += f"        .{{ {size}, &expected }},\n"
    body += "    );\n"
    return body
