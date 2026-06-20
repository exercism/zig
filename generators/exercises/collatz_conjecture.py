from lib import zint, is_error

IMPORT_SELF = True
HEADER = "const ComputationError = collatz_conjecture.ComputationError;"


def gen_case(case):
    number = zint(case["input"]["number"])
    expected = case["expected"]
    if is_error(expected):
        return (
            "    const expected = ComputationError.IllegalArgument;\n"
            f"    const actual = collatz_conjecture.steps({number});\n"
            "    try testing.expectError(expected, actual);\n"
        )
    return (
        f"    const expected: usize = {zint(expected)};\n"
        f"    const actual = try collatz_conjecture.steps({number});\n"
        "    try testing.expectEqual(expected, actual);\n"
    )
