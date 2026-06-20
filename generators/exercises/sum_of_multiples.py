from lib import zint, zarray

IMPORT_SELF = False
HEADER = 'const sum = @import("sum_of_multiples.zig").sum;'


def _gz(n):
    # The track test file only digit-groups values that are five digits or more.
    return zint(n) if int(n) >= 10000 else str(n)


def gen_case(case):
    factors = zarray([_gz(f) for f in case["input"]["factors"]], "u32")
    limit = _gz(case["input"]["limit"])
    expected = _gz(case["expected"])
    comment = ""
    if case.get("comment"):
        comment = f"    // {case['comment']}\n"
    return (
        f"{comment}"
        f"    const expected: u64 = {expected};\n"
        f"    const factors = {factors};\n"
        f"    const limit = {limit};\n"
        "    const actual = try sum(testing.allocator, &factors, limit);\n"
        "    try testing.expectEqual(expected, actual);\n"
    )
