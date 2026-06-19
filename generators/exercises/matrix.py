from lib import zstr

HEADER = "const row = matrix.row;\nconst column = matrix.column;\n"


def gen_case(case):
    prop = case["property"]  # "row" or "column"
    s = case["input"]["string"]
    index = case["input"]["index"]
    expected = ", ".join(str(v) for v in case["expected"])
    return (
        f"    const expected = &[_]i16{{ {expected} }};\n"
        f"    const s = {zstr(s)};\n"
        f"    const actual = try {prop}(testing.allocator, s, {index});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(i16, expected, actual);\n"
    )
