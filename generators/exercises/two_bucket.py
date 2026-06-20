from lib import is_error

HEADER = "const measure = two_bucket.measure;\n"


def gen_case(case):
    inp = case["input"]
    one = inp["bucketOne"]
    two = inp["bucketTwo"]
    goal = inp["goal"]
    start = inp["startBucket"]
    call = f"measure({one}, {two}, {goal}, .{start})"
    expected = case["expected"]
    if is_error(expected):
        return (
            f"    const result = {call};\n    try testing.expectEqual(result, null);\n"
        )
    return (
        f"    if ({call}) |result| {{\n"
        f"        try testing.expectEqual({expected['moves']}, result.moves);\n"
        f"        try testing.expectEqual(.{expected['goalBucket']}, result.goal_bucket);\n"
        f"        try testing.expectEqual({expected['otherBucket']}, result.other_bucket);\n"
        "    } else {\n"
        "        try testing.expect(false);\n"
        "    }\n"
    )
