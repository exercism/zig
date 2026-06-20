from lib import zstr

IMPORT_SELF = False

HEADER = 'const isValid = @import("luhn.zig").isValid;'


def describe(case, parent):
    # The target uses "cannot" where the canonical data uses "can not".
    return case["description"].replace("can not", "cannot")


def gen_case(case):
    value = case["input"]["value"]
    expected = case["expected"]
    neg = "" if expected else "!"
    return f"    try testing.expect({neg}isValid({zstr(value)}));\n"
