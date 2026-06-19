from lib import is_error

HEADER = (
    "const transmitSequence = intergalactic_transmission.transmitSequence;\n"
    "const decodeMessage = intergalactic_transmission.decodeMessage;\n"
    "const TransmissionError = intergalactic_transmission.TransmissionError;\n"
)


def _bytes_lit(values):
    # Keep the canonical hex spelling (e.g. 0x03) so the byte values stay legible.
    inner = ", ".join(f"0x{int(v, 16):02x}" for v in values)
    return "{ " + inner + " }" if values else "{}"


def gen_case(case):
    prop = case["property"]
    message = case["input"]["message"]
    expected = case["expected"]
    msg_lit = _bytes_lit(message)

    if is_error(expected):
        return (
            f"    const message = [_]u8{msg_lit};\n"
            f"    try testing.expectError(TransmissionError.WrongParity, {prop}(testing.allocator, &message));\n"
        )

    exp_lit = _bytes_lit(expected)
    return (
        f"    const message = [_]u8{msg_lit};\n"
        f"    const expected = [_]u8{exp_lit};\n"
        f"    const actual = try {prop}(testing.allocator, &message);\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices(u8, &expected, actual);\n"
    )
