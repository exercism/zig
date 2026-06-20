from lib import zint

HEADER = "const ColorBand = resistor_color_duo.ColorBand;\n"


def describe(case, parent):
    if "cases" in case:
        return case["description"]
    return case["description"][0].lower() + case["description"][1:]


def gen_case(case):
    bands = ", ".join("." + c for c in case["input"]["colors"])
    expected = case["expected"]
    return (
        f"    const array = [_]ColorBand{{ {bands} }};\n"
        f"    const expected: usize = {zint(expected)};\n"
        f"    const actual = resistor_color_duo.colorCode(array);\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
