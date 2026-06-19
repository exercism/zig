from lib import zint, zarray, is_error

# Canonical error message -> the example solution's ChangeError variant.
_ERROR_MAP = {
    "can't make target with given coins": "UnreachableTarget",
    "target can't be negative": "NegativeTarget",
}


def gen_case(case):
    coins = case["input"]["coins"]
    target = case["input"]["target"]
    expected = case["expected"]
    coins_lit = zarray([zint(c) for c in coins], "u64")
    if is_error(expected):
        variant = _ERROR_MAP[expected["error"]]
        return (
            f"    const coins = {coins_lit};\n"
            f"    const actual = change.findFewestCoins(testing.allocator, &coins, {zint(target)});\n"
            f"    try testing.expectError(change.ChangeError.{variant}, actual);\n"
        )
    expected_lit = zarray([zint(v) for v in expected], "u64")
    return (
        f"    const expected = {expected_lit};\n"
        f"    const coins = {coins_lit};\n"
        f"    const actual = try change.findFewestCoins(testing.allocator, &coins, {zint(target)});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(u64, &expected, actual);\n"
    )
