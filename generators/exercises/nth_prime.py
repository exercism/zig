from lib import zint, is_error

# The "there is no zeroth prime" error case is excluded via `include = false`.


def order_key(case):
    # Order by n so the supplemental cases (3rd/4th/5th/7th) interleave with the canonical
    # ones (1st/2nd/6th/big) by ascending prime index, matching the original ordering.
    return case["input"]["number"]


def gen_case(case):
    n = case["input"]["number"]
    expected = case["expected"]
    if is_error(expected):
        # Defensive: not reached because the error case is excluded above.
        return (
            f"    const actual = nth_prime.prime(testing.allocator, {zint(n)});\n"
            f"    try testing.expectError(error.NoZerothPrime, actual);\n"
        )
    return (
        f"    const p = try nth_prime.prime(testing.allocator, {zint(n)});\n"
        f"    try testing.expectEqual({zint(expected)}, p);\n"
    )
