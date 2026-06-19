from lib import zmultiline


def gen_case(case):
    inp = case["input"]
    start, take = inp["startBottles"], inp["takeDown"]
    expected = zmultiline("\n".join(case["expected"]))
    return (
        "    const buffer_size = 4000;\n"
        "    var buffer: [buffer_size]u8 = undefined;\n"
        "    const expected: []const u8 =\n"
        f"{expected}\n"
        "    ;\n"
        f"    const actual = try bottle_song.recite(&buffer, {start}, {take});\n"
        "    try testing.expectEqualStrings(expected, actual);\n"
    )
