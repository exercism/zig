_METHODS = {
    "equilateral": "isEquilateral",
    "isosceles": "isIsosceles",
    "scalene": "isScalene",
}

# Sides are passed through `makeTriangle`'s runtime parameters, so a solution that declares
# `Triangle.init`'s parameters `comptime` is rejected at compile time.
# See https://forum.exercism.org/t/zig-track-needs-tests-against-comptime-abuse-and-other-kinds-of-cheating/59830/
HEADER = """fn makeTriangle(a: f64, b: f64, c: f64) triangle.TriangleError!triangle.Triangle {
    return triangle.Triangle.init(a, b, c);
}
"""


def describe(case, parent):
    desc = case.get("description")
    prop = case.get("property")
    if prop and prop not in desc:
        return f"{prop} {desc}"
    return desc


def _fmt(n):
    # Integers stay integral (2 -> "2"); floats keep their literal form (0.5 -> "0.5").
    if isinstance(n, float) and not n.is_integer():
        return repr(n)
    return str(int(n))


def _is_valid(a, b, c):
    return not (a + b <= c or a + c <= b or b + c <= a)


def gen_case(case):
    a, b, c = case["input"]["sides"]
    method = _METHODS[case["property"]]
    args = f"{_fmt(a)}, {_fmt(b)}, {_fmt(c)}"
    if not _is_valid(a, b, c):
        return (
            f"    try testing.expectError(triangle.TriangleError.Invalid, makeTriangle({args}));\n"
        )
    bang = "" if case["expected"] else "!"
    return (
        f"    const actual = try makeTriangle({args});\n"
        f"    try testing.expect({bang}actual.{method}());\n"
    )
