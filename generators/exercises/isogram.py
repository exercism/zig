from lib import zstr


def gen_case(case):
    phrase = case["input"]["phrase"]
    expected = case["expected"]
    neg = "" if expected else "!"
    return f"    try testing.expect({neg}isogram.isIsogram({zstr(phrase)}));\n"
