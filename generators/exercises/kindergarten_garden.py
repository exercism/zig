from lib import zstr, zmultiline


def gen_case(case):
    diagram = case["input"]["diagram"]
    student = case["input"]["student"]
    expected = "{ " + ", ".join("." + p for p in case["expected"]) + " }"
    return (
        f"    const diagram: []const u8 =\n"
        f"{zmultiline(diagram)}\n"
        f"    ;\n"
        f"    const expected = .{expected};\n"
        f"    const actual = kindergarten_garden.plants(diagram, {zstr(student)});\n"
        f"    try testing.expectEqual(expected, actual);\n"
    )
