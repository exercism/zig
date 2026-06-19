from lib import zarray


def gen_case(case):
    value = case["input"]["value"]
    expected = case["expected"]
    return (
        f"    const expected = {zarray(expected, 'u64')};\n"
        f"    const actual = try prime_factors.factors(testing.allocator, {value});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(u64, &expected, actual);\n"
    )
