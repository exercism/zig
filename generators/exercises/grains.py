from lib import zint, is_error

HEADER = "const ChessboardError = grains.ChessboardError;\n"

_RENAME = {
    "square 0 is invalid": "square 0 produces an error",
    "square greater than 64 is invalid": "square greater than 64 produces an error",
}


def describe(case, parent):
    if "cases" in case:
        return case["description"]
    return _RENAME.get(case["description"], case["description"])


def gen_case(case):
    prop = case["property"]
    if prop == "total":
        expected = case["expected"]
        return (
            f"    const expected: u64 = {zint(expected)};\n"
            f"    const actual = grains.total();\n"
            f"    try testing.expectEqual(expected, actual);\n"
        )
    # property == "square"
    index = case["input"]["square"]
    expected = case["expected"]
    if is_error(expected):
        return (
            f"    const expected = ChessboardError.IndexOutOfBounds;\n"
            f"    const actual = grains.square({zint(index)});\n"
            f"    try testing.expectError(expected, actual);\n"
        )
    return (
        f"    const expected: u64 = {zint(expected)};\n"
        f"    const actual = try grains.square({zint(index)});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
