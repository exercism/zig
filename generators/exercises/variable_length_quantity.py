from lib import zint, is_error

HEADER = (
    "const encode = variable_length_quantity.encode;\n"
    "const decode = variable_length_quantity.decode;\n"
    "const DecodeError = variable_length_quantity.DecodeError;\n"
)


def describe(case, parent):
    # Special join: "<property> - <description>" rather than the default dash join.
    desc = case["description"]
    prop = case.get("property")
    if prop and "cases" not in case:
        return f"{prop} - {desc}"
    return desc


def gen_case(case):
    prop = case["property"]
    integers = case["input"]["integers"]
    expected = case["expected"]
    in_ty = "u32" if prop == "encode" else "u8"
    integers_lit = (
        "{ " + ", ".join(zint(v) for v in integers) + " }" if integers else "{}"
    )

    if is_error(expected):
        return (
            f"    const integers = [_]{in_ty}{integers_lit};\n"
            f"    const actual = {prop}(testing.allocator, &integers);\n"
            f"    try testing.expectError(DecodeError.IncompleteSequence, actual);\n"
        )

    out_ty = "u8" if prop == "encode" else "u32"
    expected_lit = (
        "{ " + ", ".join(zint(v) for v in expected) + " }" if expected else "{}"
    )
    return (
        f"    const expected = [_]{out_ty}{expected_lit};\n"
        f"    const integers = [_]{in_ty}{integers_lit};\n"
        f"    const actual = try {prop}(testing.allocator, &integers);\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices({out_ty}, &expected, actual);\n"
    )
