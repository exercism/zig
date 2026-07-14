from lib import zmultiline

HEADER = r"""
fn testRecite(expected: []const u8, start_bottles: u32, take_down: u32) !void {
    var buffer: [1821]u8 = undefined;
    const actual = try bottle_song.recite(&buffer, start_bottles, take_down);
    try testing.expectEqual(@as([*]const u8, &buffer), actual.ptr);
    try testing.expectEqualStrings(expected, actual);
}
"""


def gen_case(case):
    inp = case["input"]
    start, take = inp["startBottles"], inp["takeDown"]
    expected = zmultiline("\n".join(case["expected"]))
    return f"    try testRecite(\n{expected}\n    , {start}, {take});\n"
