from lib import zstr, zcomment_list

HEADER = "const winner = connect.winner;\n"


def gen_case(case):
    rows = case["input"]["board"]
    expected = case["expected"] or "."
    # One row per line (trailing `//`) so the board grid stays readable.
    board = zcomment_list([zstr(row) for row in rows])
    return (
        f"    const board = [_][]const u8{board};\n"
        f"    try testing.expectEqual('{expected}', winner(testing.allocator, &board));\n"
    )
