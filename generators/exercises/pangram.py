from lib import zstr


def gen_case(case):
    sentence = case["input"]["sentence"]
    expected = case["expected"]
    neg = "" if expected else "!"
    return f"    try testing.expect({neg}pangram.isPangram({zstr(sentence)}));\n"
