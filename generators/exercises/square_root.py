def gen_case(case):
    radicand = case["input"]["radicand"]
    expected = case["expected"]
    return (
        f"    const expected: usize = {expected};\n"
        f"    const actual = square_root.squareRoot({radicand});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
