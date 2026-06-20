from lib import zstr

HEADER = "\nconst buffer_size = 100;"


def gen_case(case):
    name = case["input"]["name"]
    expected = case["expected"]
    arg = "null" if name is None else zstr(name)
    return (
        f"    var response: [buffer_size]u8 = undefined;\n"
        f"    const expected = {zstr(expected)};\n"
        f"    const actual = try two_fer.twoFer(&response, {arg});\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
