from lib import is_error

HEADER = "const QueenError = queen_attack.QueenError;"


def describe(case, parent):
    # The target uses only the leaf description, dropping the canonical group name.
    return case["description"]


def order_key(case):
    # The "fields" supplement is the first test in the target; everything else keeps
    # canonical order (stable sort).
    return 0 if case["property"] == "fields" else 1


def gen_case(case):
    prop = case["property"]
    inp = case["input"]
    if prop == "fields":
        n = case["expected"]
        return f"    try testing.expectEqual({n}, std.meta.fields(queen_attack.Queen).len);\n"
    if prop == "create":
        pos = inp["queen"]["position"]
        row, col = pos["row"], pos["column"]
        if is_error(case["expected"]):
            return (
                f"    const queen = queen_attack.Queen.init({row}, {col});\n"
                f"    try testing.expectError(QueenError.InitializationFailure, queen);\n"
            )
        # Valid position: allow any field names, all equal to the input value.
        return (
            f"    const queen = try queen_attack.Queen.init({row}, {col});\n"
            f"    // Allow the fields to have any name.\n"
            f"    const fields = std.meta.fields(@TypeOf(queen));\n"
            f"    inline for (fields) |f| {{\n"
            f"        const actual = @field(queen, f.name);\n"
            f"        const expected = @as(@TypeOf(actual), {row});\n"
            f"        try testing.expectEqual(expected, actual);\n"
            f"    }}\n"
        )
    # canAttack
    w = inp["white_queen"]["position"]
    b = inp["black_queen"]["position"]
    expected = case["expected"]
    bang = "" if expected else "!"
    return (
        f"    const white = try queen_attack.Queen.init({w['row']}, {w['column']});\n"
        f"    const black = try queen_attack.Queen.init({b['row']}, {b['column']});\n"
        f"    try testing.expect({bang}try white.canAttack(black));\n"
    )
