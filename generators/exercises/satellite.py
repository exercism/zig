from lib import is_error

HEADER = """const Tree = satellite.Tree;
const TraversalError = satellite.TraversalError;
"""

_ERROR_MAP = {
    "traversals must have the same length": "DifferentLengths",
    "traversals must have the same elements": "DifferentItems",
    "traversals must contain unique items": "NonUniqueItems",
}


def _u8_array(name, chars):
    if not chars:
        return f"const {name} = [_]u8{{}};\n"
    inner = ", ".join(f"'{c}'" for c in chars)
    return f"const {name} = [_]u8{{ {inner} }};\n"


def _traverse(expr, name, node, out):
    if not node:
        out.append(f"try testing.expectEqual(null, {expr});\n")
        return

    if len(name) > 1 and name[0] == "o":
        name = name[1:]

    out.append(f"if ({expr}) |{name}| {{\n")
    out.append(f"try testing.expectEqual('{node['v']}', {name}.data);\n")
    _traverse(name + ".left", name + "l", node.get("l"), out)
    _traverse(name + ".right", name + "r", node.get("r"), out)
    out.append("} else {\n")
    out.append(f"try testing.expectEqual(false, true); // {expr} should not be null\n")
    out.append("}\n")


def gen_case(case):
    inp = case["input"]
    expected = case["expected"]
    preorder = inp["preorder"]
    inorder = inp["inorder"]

    out = [_u8_array("preorder", preorder), _u8_array("inorder", inorder)]

    if is_error(expected):
        err = _ERROR_MAP[expected["error"]]
        out.append(
            f"try testing.expectError(TraversalError.{err}, "
            "Tree.initFromTraversals(testing.allocator, &preorder, &inorder));\n"
        )
        return "".join(out)

    out.append(
        "var tree = try Tree.initFromTraversals(testing.allocator, &preorder, &inorder);\n"
    )
    out.append("defer tree.deinit();\n")

    if not expected:
        out.append("try testing.expectEqual(null, tree.root);\n")
    else:
        _traverse("tree.root", "o", expected, out)

    return "".join(out)
