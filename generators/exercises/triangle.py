_METHODS = {
    "equilateral": "isEquilateral",
    "isosceles": "isIsosceles",
    "scalene": "isScalene",
}


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
            f"    const actual = triangle.Triangle.init({args});\n"
            f"    try testing.expectError(triangle.TriangleError.Invalid, actual);\n"
        )
    bang = "" if case["expected"] else "!"
    return (
        f"    const actual = try triangle.Triangle.init({args});\n"
        f"    try testing.expect({bang}actual.{method}());\n"
    )
