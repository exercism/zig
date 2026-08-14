from lib import zstr

HEADER = r"""
fn testFormat(allocator: std.mem.Allocator, expected: []const u8, name: []const u8, number: u10) !void {
    const actual = try line_up.format(allocator, name, number);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
"""


def gen_case(case):
    name = case["input"]["name"]
    number = case["input"]["number"]
    expected = case["expected"]
    return (
        "    try testing.checkAllAllocationFailures(\n"
        "        testing.allocator,\n"
        "        testFormat,\n"
        f"        .{{ {zstr(expected)}, {zstr(name)}, {number} }},\n"
        "    );\n"
    )
