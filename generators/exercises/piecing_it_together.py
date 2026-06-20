HEADER = """const jigsawData = piecing_it_together.jigsawData;
const PuzzleError = piecing_it_together.PuzzleError;
const Format = piecing_it_together.Format;
const PartialInformation = piecing_it_together.PartialInformation;
const FullInformation = piecing_it_together.FullInformation;
"""

KEYS = ["pieces", "border", "inside", "rows", "columns", "aspectRatio", "format"]


def _struct(puzzle):
    result = "{\n"
    for key in KEYS:
        if key in puzzle:
            value = puzzle[key]
            if key == "format":
                value = "." + value
            result += f"        .{key} = {value},\n"
    result += "    }"
    return result


def gen_case(case):
    expected = case["expected"]
    out = f"    const puzzle = PartialInformation{_struct(case['input'])};\n"
    if "error" in expected:
        error = expected["error"].replace(" data", "Data")
        out += "    const actual = jigsawData(puzzle);\n"
        out += f"    try testing.expectError(PuzzleError.{error}, actual);\n"
    else:
        out += f"    const expected = FullInformation{_struct(expected)};\n"
        out += "    const actual = try jigsawData(puzzle);\n"
        out += "    try testing.expectEqual(expected, actual);\n"
    return out
