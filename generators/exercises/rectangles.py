from lib import zstr, zint, zcomment_list

USE_MEM = False


def gen_case(case):
    strings = case["input"]["strings"]
    expected = case["expected"]
    # One row per line (each with a trailing `//`) so students can see the rectangle.
    rows = zcomment_list([zstr(s) for s in strings])
    return (
        f"    const strings = [_][]const u8{rows};\n"
        f"    const count = rectangles.rectangles(&strings);\n"
        f"    try testing.expectEqual({zint(expected)}, count);\n"
    )
