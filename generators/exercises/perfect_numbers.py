from lib import zint

HEADER = (
    "const Classification = perfect_numbers.Classification;\n"
    "const classify = perfect_numbers.classify;\n"
)

# The two error cases ("zero is rejected ...", "negative integer is rejected ...") are
# excluded via `include = false` in tests.toml: the example solution's `classify` asserts
# a nonzero positive input at comptime and has no error variant.


def describe(case, parent):
    # perfect-numbers never joins the parent description, and lowercases the result.
    return case["description"].lower()


def gen_case(case):
    n = case["input"]["number"]
    expected = case["expected"]
    return (
        f"    const expected = Classification.{expected};\n"
        f"    const actual = classify({zint(n)});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
