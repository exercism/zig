from lib import zint

HEADER = "const ColorBand = resistor_color.ColorBand;\n"


def describe(case, parent):
    if "cases" in case:
        return case["description"]
    if case.get("property") == "colorCode":
        return case["input"]["color"]
    return "colors"


def gen_case(case):
    prop = case["property"]
    if prop == "colorCode":
        color = case["input"]["color"]
        expected = case["expected"]
        return (
            f"    const expected: usize = {zint(expected)};\n"
            f"    const actual = resistor_color.colorCode(.{color});\n"
            f"    try testing.expectEqual(expected, actual);\n"
        )
    # property == "colors": the ordered list of all color bands. Emit five per row
    # with a trailing comma so `zig fmt` keeps (and column-aligns) the grid layout.
    bands = ["." + c for c in case["expected"]]
    rows = []
    for i in range(0, len(bands), 5):
        rows.append("        " + ", ".join(bands[i : i + 5]) + ",")
    grid = "\n".join(rows)
    return (
        f"    const expected = &[_]ColorBand{{\n{grid}\n    }};\n"
        f"    const actual = resistor_color.colors();\n"
        f"    try testing.expectEqualSlices(ColorBand, expected, actual);\n"
    )
