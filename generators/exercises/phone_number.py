from lib import zstr, is_error


def gen_case(case):
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    if is_error(expected):
        expected_lit = "null"
    else:
        expected_lit = f"{zstr(expected)}.*"
    return (
        f"    const expected: ?[10]u8 = {expected_lit};\n"
        f"    const actual = phone_number.clean({zstr(phrase)});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
