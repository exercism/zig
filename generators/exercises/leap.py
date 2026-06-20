def gen_case(case):
    year = case["input"]["year"]
    bang = "" if case["expected"] else "!"
    return f"    try testing.expect({bang}leap.isLeapYear({year}));\n"
