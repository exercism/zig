from lib import zstr

HEADER = "const transform = etl.transform;\n"


def gen_case(case):
    legacy = case["input"]["legacy"]
    expected = case["expected"]

    lines = [
        "    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);\n"
    ]
    for score in sorted(legacy):
        letters = legacy[score]
        lines.append(f"    try legacy.put({int(score)}, {zstr(''.join(letters))});\n")
    lines.append("    var actual = try transform(testing.allocator, legacy);\n")
    lines.append("    legacy.deinit();\n\n")
    lines.append(f"    try testing.expectEqual({len(expected)}, actual.count());\n")
    for letter, score in expected.items():
        lines.append(f"    try testing.expectEqual({score}, actual.get('{letter}'));\n")
    lines.append("    actual.deinit();\n")
    return "".join(lines)
