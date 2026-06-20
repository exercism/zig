from lib import zint


def _signal(name):
    return "." + name.replace(" ", "_")


def gen_case(case):
    number = case["input"]["number"]
    expected = case["expected"]
    signals = ", ".join(_signal(name) for name in expected)
    if signals:
        signals = " " + signals + " "
    return (
        f"    const expected = &[_]secret_handshake.Signal{{{signals}}};\n"
        f"    const actual = try secret_handshake.calculateHandshake(testing.allocator, {zint(number)});\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(secret_handshake.Signal, expected, actual);\n"
    )
