from lib import zint

HEADER = (
    "const isAllergicTo = allergies.isAllergicTo;\n"
    "const initAllergenSet = allergies.initAllergenSet;\n"
)


def describe(case, parent):
    # Leaf cases carry their own description; group nodes pass it down via `parent`.
    if "cases" in case:
        return case["description"]
    prop = case.get("property")
    desc = case["description"]
    if prop == "allergicTo":
        return f"{case['input']['item']}: {desc}"
    if prop == "list":
        return f"initAllergenSet: {desc}"
    return desc


def gen_case(case):
    prop = case["property"]
    if prop == "allergicTo":
        item = case["input"]["item"]
        score = case["input"]["score"]
        expected = case["expected"]
        bang = "" if expected else "!"
        return f"    try testing.expect({bang}isAllergicTo({zint(score)}, .{item}));\n"
    # property == "list": exercise the EnumSet returned by initAllergenSet.
    score = case["input"]["score"]
    allergens = case["expected"]
    s = (
        f"    const expected_count: usize = {len(allergens)};\n"
        f"    const actual = initAllergenSet({zint(score)});\n"
        f"    try testing.expectEqual(expected_count, actual.count());\n"
    )
    for a in allergens:
        s += f"    try testing.expect(actual.contains(.{a}));\n"
    return s
