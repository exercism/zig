from lib import zstr


def describe(case, parent):
    return case["description"].lower()


def gen_case(case):
    return (
        f"    const expected = {zstr(case['expected'])};\n"
        f"    const actual = hello_world.hello();\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
