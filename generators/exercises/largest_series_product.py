from lib import zstr, is_error


def gen_case(case):
    inp = case["input"]
    digits = inp["digits"]
    span = inp["span"]
    e = case["expected"]

    if is_error(e):
        if span < 0:
            err = "NegativeSpan"
        elif span > len(digits):
            err = "InsufficientDigits"
        else:
            err = "InvalidCharacter"
        return (
            f"    const actual = largest_series_product.largestProduct({zstr(digits)}, {span});\n"
            f"    try testing.expectError(largest_series_product.SeriesError.{err}, actual);\n"
        )

    return (
        f"    const expected: u64 = {e};\n"
        f"    const actual = try largest_series_product.largestProduct({zstr(digits)}, {span});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
