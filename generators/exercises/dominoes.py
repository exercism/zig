def gen_case(case):
    stones = case["input"]["dominoes"]
    expected = case["expected"]
    op = "" if expected else "!"

    serialized = ", ".join(f"[2]u3{{ {a}, {b} }}" for a, b in stones)
    if serialized:
        stones_lit = f"&[_][2]u3{{ {serialized} }}"
    else:
        stones_lit = "&[_][2]u3{}"
    return (
        f"    const stones = {stones_lit};\n"
        f"    try testing.expect({op}try dominoes.canChain(testing.allocator, stones));\n"
    )
