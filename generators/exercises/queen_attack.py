HEADER = """
fn testCreate(row: u3, col: u3) !void {
    const queen = queen_attack.Queen.init(row, col);
    // Allow the fields to have any name, in any order.
    const field_names = @typeInfo(@TypeOf(queen)).@"struct".field_names;
    inline for (field_names) |name| {
        const actual = @field(queen, name);
        try testing.expect(actual == row or actual == col);
    }
}
"""


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
        return f"    try testing.expectEqual({n}, @typeInfo(queen_attack.Queen).@\"struct\".field_names.len);\n"
    if prop == "create":
        pos = inp["queen"]["position"]
        return f"    try testCreate({pos['row']}, {pos['column']});\n"
    # canAttack
    w = inp["white_queen"]["position"]
    b = inp["black_queen"]["position"]
    bang = "" if case["expected"] else "!"
    return (
        f"    const white = queen_attack.Queen.init({w['row']}, {w['column']});\n"
        f"    const black = queen_attack.Queen.init({b['row']}, {b['column']});\n"
        f"    try testing.expect({bang}white.canAttack(black));\n"
    )
