from lib import zstr


def gen_case(case):
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    return (
        f"    const expected: []const u8 = {zstr(expected)};\n"
        f"    const actual = micro_blog.truncate({zstr(phrase)});\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
