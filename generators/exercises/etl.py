from lib import zstr

HEADER = "const transform = etl.transform;\n"


def gen_case(case):
    legacy = case["input"]["legacy"]
    expected = case["expected"]

    lines = [
        "    var legacy = std.AutoHashMap(i5, []const u8).init(testing.allocator);\n"
        "    defer legacy.deinit();\n"
    ]
    for score in sorted(legacy):
        letters = legacy[score]
        lines.append(f"    try legacy.put({int(score)}, {zstr(''.join(letters))});\n")
    lines.append("\n    var actual = try transform(testing.allocator, legacy);\n")
    lines.append("    defer actual.deinit();\n")
    lines.append(f"    try testing.expectEqual({len(expected)}, actual.count());\n")
    for letter, score in expected.items():
        lines.append(f"    try testing.expectEqual({score}, actual.get('{letter}'));\n")
    return "".join(lines)
