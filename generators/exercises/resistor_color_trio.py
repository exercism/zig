from lib import zstr

HEADER = (
    "const ColorBand = resistor_color_trio.ColorBand;\n"
    "\n"
    "fn labelTest(allocator: std.mem.Allocator, colors: []const ColorBand, expected: []const u8) anyerror!void {\n"
    "    const actual = try resistor_color_trio.label(allocator, colors);\n"
    "    defer testing.allocator.free(actual);\n"
    "    try testing.expectEqualStrings(expected, actual);\n"
    "}\n"
)


def gen_case(case):
    colors = ", ".join("." + c for c in case["input"]["colors"])
    expected = case["expected"]
    label = f"{expected['value']} {expected['unit']}"
    return (
        f"    const colors = [_]ColorBand{{ {colors} }};\n"
        f"    const expected: []const u8 = {zstr(label)};\n"
        f"    try std.testing.checkAllAllocationFailures(\n"
        f"        std.testing.allocator,\n"
        f"        labelTest,\n"
        f"        .{{ &colors, expected }},\n"
        f"    );\n"
    )
