def _bitset(numbers):
    result = 0
    for number in numbers:
        result |= 1 << (number - 1)
    return result


def gen_case(case):
    cage = case["input"]["cage"]
    sm = cage["sum"]
    size = cage["size"]
    exclude = bin(_bitset(cage["exclude"]))

    combos = sorted(_bitset(combo) for combo in case["expected"])
    expectation = "{ " + ", ".join(bin(c) for c in combos) + " }"

    return (
        "    const buffer_size = 200;\n"
        "    var buffer: [buffer_size]u9 = undefined;\n"
        f"    const expected = [_]u9{expectation};\n"
        f"    const actual = killer_sudoku_helper.combinations(&buffer, {sm}, {size}, {exclude});\n"
        "    try testing.expectEqualSlices(u9, &expected, actual);\n"
    )
