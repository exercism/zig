from lib import zint

HEADER = """const flatten = flatten_array.flatten;
const Box = flatten_array.Box;

fn flattenTest(
    allocator: std.mem.Allocator,
    box: Box,
    expected: []const i12,
) !void {
    const actual: []i12 = try flatten(allocator, box);
    defer allocator.free(actual);
    try testing.expectEqualSlices(i12, expected, actual);
}
"""


def _render_box(value):
    """Render a canonical array element into a Box expression."""
    if value is None:
        return ".none"
    if isinstance(value, list):
        if not value:
            return "Box{ .many = &[_]Box{} }"
        return "Box{\n.many = " + _render_many(value) + ",\n}"
    return f"Box{{ .one = {zint(value)} }}"


def _render_many(elements):
    """Render a list of elements as &[_]Box{ ... } with trailing // comments."""
    if not elements:
        return "&[_]Box{}"
    body = "".join(f"\n{_render_box(e)}, //" for e in elements)
    return "&[_]Box{" + body + "\n}"


def gen_case(case):
    array = case["input"]["array"]
    expected = case["expected"]

    if not array:
        box = "const box: Box = Box{ .many = &[_]Box{} };\n"
    else:
        box = "const box: Box = Box{\n.many = " + _render_many(array) + ",\n};\n"

    if expected:
        exp_inner = ", ".join(zint(v) for v in expected)
        exp = f"const expected = [_]i12{{ {exp_inner} }};\n"
    else:
        exp = "const expected = [_]i12{};\n"

    out = (
        box
        + exp
        + "try std.testing.checkAllAllocationFailures(\n"
        + "std.testing.allocator,\n"
        + "flattenTest,\n"
        + ".{ box, &expected },\n"
        + ");\n"
    )
    return out
