from lib import zbool, zstr

HEADER = """
fn testIsIsogram(phrase: []const u8, expected: bool) !void {
    try testing.expectEqual(expected, isogram.isIsogram(phrase));
}
"""


def gen_case(case):
    phrase = zstr(case["input"]["phrase"])
    expected = zbool(case["expected"])
    return f"    try testIsIsogram({phrase}, {expected});\n"
