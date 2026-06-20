from lib import zcomment_list

HEADER = "const saddlePoints = saddle_points.saddlePoints;\nconst Point = saddle_points.Point;\n"


def gen_case(case):
    matrix = case["input"]["matrix"]
    expected = case["expected"]

    m = len(matrix)
    n = len(matrix[0]) if m else 0

    rows = [f"[{n}]i32{{{', '.join(str(v) for v in row)}}}" for row in matrix]
    matrix_lit = f"[{m}][{n}]i32{zcomment_list(rows)}"

    points = sorted(expected, key=lambda p: (p["row"], p["column"]))
    point_elems = [f".{{ .row = {p['row']}, .column = {p['column']} }}" for p in points]
    expected_lit = f"[_]Point{zcomment_list(point_elems)}"

    return (
        f"    const matrix = {matrix_lit};\n"
        f"    const expected = {expected_lit};\n"
        f"    const actual = try saddlePoints({m}, {n}, testing.allocator, matrix);\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(Point, &expected, actual);\n"
    )
