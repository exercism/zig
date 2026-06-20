HEADER = (
    "const Triplet = pythagorean_triplet.Triplet;\n"
    "const tripletsWithSum = pythagorean_triplet.tripletsWithSum;\n"
)


def gen_case(case):
    n = case["input"]["n"]
    triplets = case["expected"]
    count = len(triplets)
    lines = [f"    const expected: [{count}]Triplet = .{{"]
    for a, b, c in triplets:
        lines.append(f"        Triplet.init({a}, {b}, {c}),")
    lines.append("    };")
    body = "\n".join(lines) + "\n"
    body += f"    const actual = try tripletsWithSum(testing.allocator, {n});\n"
    body += "    defer testing.allocator.free(actual);\n"
    body += "    try testing.expectEqualSlices(Triplet, &expected, actual);\n"
    return body
