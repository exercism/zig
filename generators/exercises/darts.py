from lib import zfloat

IMPORT_SELF = True


def describe(case, parent):
    return case["description"][0].lower() + case["description"][1:]


# The committed target flips the signs on this symmetric case (score depends only
# on x^2 + y^2, so it is equivalent to the canonical x=-3.5, y=3.5).
_INPUT_OVERRIDE = {
    "just within the middle circle": {"x": 3.5, "y": -3.5},
}


def gen_case(case):
    inp = _INPUT_OVERRIDE.get(case["description"], case["input"])
    x = zfloat(inp["x"])
    y = zfloat(inp["y"])
    e = case["expected"]
    return (
        f"    const expected: usize = {e};\n"
        f"    const coordinate = darts.Coordinate.init({x}, {y});\n"
        f"    const actual = coordinate.score();\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
