from lib import zint

IMPORT_SELF = True

_LABEL = {
    "squareOfSum": "square of sum up to",
    "sumOfSquares": "sum of squares up to",
    "differenceOfSquares": "difference of squares up to",
}


def describe(case, parent):
    # Leaf cases carry a property; group nodes do not. Group descriptions are
    # dropped so leaves get a clean "<label> up to <n>" name.
    if "cases" in case:
        return None
    number = case["input"]["number"]
    return f"{_LABEL[case['property']]} {number}"


def gen_case(case):
    number = zint(case["input"]["number"])
    expected = zint(case["expected"])
    prop = case["property"]
    return (
        f"    const expected: usize = {expected};\n"
        f"    const actual = difference_of_squares.{prop}({number});\n"
        "    try testing.expectEqual(expected, actual);\n"
    )
