USE_MEM = False

HEADER = """const Palindrome = palindrome_products.Palindrome;
const smallest = palindrome_products.smallest;
const largest = palindrome_products.largest;
"""


def gen_case(case):
    prop = case["property"]
    min_ = case["input"]["min"]
    max_ = case["input"]["max"]
    expected = case["expected"]
    value = expected["value"]
    factors = expected["factors"]

    if value is None:
        return (
            f"    if (try {prop}(testing.allocator, {min_}, {max_})) |_| {{\n"
            "        try testing.expect(false);\n"
            "    }\n"
        )

    out = [
        f"    if (try {prop}(testing.allocator, {min_}, {max_})) |actual| {{\n",
        "        defer testing.allocator.free(actual.factors);\n",
        f"        try testing.expectEqual({value}, actual.value);\n",
        f"        try testing.expectEqual({len(factors)}, actual.factors.len);\n",
    ]
    for i, pair in enumerate(factors):
        out.append(
            f"        try testing.expectEqual({pair[0]}, actual.factors[{i}].first);\n"
        )
        out.append(
            f"        try testing.expectEqual({pair[1]}, actual.factors[{i}].second);\n"
        )
    out.append("    } else {\n")
    out.append("        try testing.expect(false);\n")
    out.append("    }\n")
    return "".join(out)
