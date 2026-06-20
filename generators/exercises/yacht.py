IMPORT_SELF = False
HEADER = 'const score = @import("yacht.zig").score;'


# Canonical order of descriptions (lowercased), with the three track-specific
# "alternative order" supplements interleaved right after their base case.
_ORDER = [
    "yacht",
    "not yacht",
    "ones",
    "ones, out of order",
    "no ones",
    "twos",
    "fours",
    "yacht counted as threes",
    "yacht of 3s counted as fives",
    "fives",
    "sixes",
    "full house two small, three big",
    "full house two small, three big, alternative order",
    "full house three small, two big",
    "full house three small, two big, alternative order",
    "two pair is not a full house",
    "four of a kind is not a full house",
    "yacht is not a full house",
    "four of a kind",
    "four of a kind alternative order",
    "yacht can be scored as four of a kind",
    "full house is not four of a kind",
    "little straight",
    "little straight as big straight",
    "four in order but not a little straight",
    "no pairs but not a little straight",
    "minimum is 1, maximum is 5, but not a little straight",
    "big straight",
    "big straight as little straight",
    "no pairs but not a big straight",
    "choice",
    "yacht as choice",
]


def describe(case, parent):
    return case["description"].lower()


def order_key(case):
    d = case["description"].lower()
    return _ORDER.index(d) if d in _ORDER else len(_ORDER)


def gen_case(case):
    dice = ", ".join(str(d) for d in case["input"]["dice"])
    category = case["input"]["category"].replace(" ", "_")
    expected = case["expected"]
    return (
        f"    const expected: u32 = {expected};\n"
        f"    const actual = score([_]u3{{ {dice} }}, .{category});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
