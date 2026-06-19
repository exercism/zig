def _ints(values):
    if not values:
        return "&[_]i32{}"
    inner = ", ".join(str(v) for v in values)
    return f"&[_]i32{{ {inner} }}"


def gen_case(case):
    list_one = case["input"]["listOne"]
    list_two = case["input"]["listTwo"]
    expected = case["expected"]  # e.g. "equal", "sublist"
    return (
        f"    const list_one = {_ints(list_one)};\n"
        f"    const list_two = {_ints(list_two)};\n"
        f"    const expected = .{expected};\n"
        f"    const actual = sublist.compare(list_one, list_two);\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
