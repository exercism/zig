from lib import zstr

IMPORT_SELF = True

HEADER = """
fn testConvert(comptime n: u32, expected: []const u8) !void {
    const buffer_size = 15; // The maximum length is for PlingPlangPlong
    var buffer: [buffer_size]u8 = undefined;
    const actual = raindrops.convert(&buffer, n);
    try testing.expectEqualStrings(expected, actual);
}
"""


def gen_case(case):
    n = case["input"]["number"]
    expected = zstr(case["expected"])
    return f"    try testConvert({n}, {expected});\n"
