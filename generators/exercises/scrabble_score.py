from lib import zstr, zint

IMPORT_SELF = False
HEADER = 'const score = @import("scrabble_score.zig").score;\n'


def gen_case(case):
    word = case["input"]["word"]
    expected = case["expected"]
    return (
        f"    const expected: u32 = {zint(expected)};\n"
        f"    const actual = score({zstr(word)});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
