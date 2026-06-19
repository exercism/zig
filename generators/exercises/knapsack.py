HEADER = "const Item = knapsack.Item;\n"


def gen_case(case):
    input = case["input"]
    items = input["items"]
    maximum_weight = input["maximumWeight"]
    expected = case["expected"]

    lines = [f"    const expected: usize = {expected};\n"]
    lines.append(f"    const items: [{len(items)}]Item = .{{\n")
    for item in items:
        lines.append(f"        Item.init({item['weight']}, {item['value']}),\n")
    lines.append("    };\n")
    lines.append(
        f"    const actual = try knapsack.maximumValue(testing.allocator, {maximum_weight}, &items);\n"
    )
    lines.append("    try testing.expectEqual(expected, actual);\n")
    return "".join(lines)
