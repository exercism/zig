def gen_case(case):
    n = case["input"]["number"]
    e = case["expected"]
    return (
        f"    const expected: usize = {e};\n"
        f"    const actual = eliuds_eggs.eggCount({n});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
