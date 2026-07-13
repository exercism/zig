from lib import zmultiline

HEADER = r"""
fn testRecite(expected: []const u8, start_verse: u32, end_verse: u32) !void {
    var buffer: [2129]u8 = undefined;
    const actual = try food_chain.recite(&buffer, start_verse, end_verse);
    try testing.expectEqual(@as([*]const u8, &buffer), actual.ptr);
    try testing.expectEqualStrings(expected, actual);
}
"""


def gen_case(case):
    inp = case["input"]
    start, end = inp["startVerse"], inp["endVerse"]
    expected = zmultiline("\n".join(case["expected"]))
    return f"    try testRecite(\n{expected}\n    , {start}, {end});\n"
