from lib import zstr

HEADER = """const encode = atbash_cipher.encode;
const decode = atbash_cipher.decode;"""


def describe(case, parent):
    # The target uses only the leaf description (no parent group prefix) and
    # lowercases it, so "encode OMG" becomes "encode omg".
    if "cases" in case:
        return None
    return case["description"].lower()


def gen_case(case):
    fn = case["property"]  # "encode" or "decode"
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    return (
        f"    const expected = {zstr(expected)};\n"
        f"    const s = {zstr(phrase)};\n"
        f"    const actual = try {fn}(testing.allocator, s);\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualStrings(expected, actual);\n"
    )
