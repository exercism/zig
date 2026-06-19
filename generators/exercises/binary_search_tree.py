HEADER = """const Tree = binary_search_tree.Tree;

fn sortedDataTest(allocator: std.mem.Allocator, tree_data: []const i32, expected: []const i32) anyerror!void {
    var tree = Tree.init(allocator);
    defer tree.deinit();
    for (tree_data) |data| {
        try tree.insert(data);
    }

    const actual = try tree.sortedData(allocator);
    defer allocator.free(actual);
    try testing.expectEqualSlices(i32, expected, actual);
}
"""


def _traverse(expr, name, expectation, out):
    if expectation is None:
        out.append(f"try testing.expectEqual(null, {expr});\n")
        return

    if len(name) > 1 and name[0] == "o":
        name = name[1:]

    out.append(f"if ({expr}) |{name}| {{\n")
    out.append(f"try testing.expectEqual({expectation['data']}, {name}.data);\n")
    _traverse(name + ".left", name + "l", expectation["left"], out)
    _traverse(name + ".right", name + "r", expectation["right"], out)
    out.append("} else {\n")
    out.append(f"try testing.expectEqual(false, true); // {expr} should not be null\n")
    out.append("}\n")


def gen_case(case):
    tree_data = case["input"]["treeData"]
    expected = case["expected"]

    if case["property"] == "data":
        out = [
            "var tree = Tree.init(testing.allocator);\n",
            "defer tree.deinit();\n",
        ]
        for element in tree_data:
            out.append(f"try tree.insert({element});\n")
        _traverse("tree.root", "o", expected, out)
        return "".join(out)

    td = "{ " + ", ".join(tree_data) + " }"
    exp = "{ " + ", ".join(expected) + " }"
    return (
        f"    const tree_data = [_]i32{td};\n"
        f"    const expected = [_]i32{exp};\n"
        "    try std.testing.checkAllAllocationFailures(\n"
        "        std.testing.allocator,\n"
        "        sortedDataTest,\n"
        "        .{ &tree_data, &expected },\n"
        "    );\n"
    )
