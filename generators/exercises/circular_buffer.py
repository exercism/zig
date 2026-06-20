HEADER = "const CircularBuffer = circular_buffer.CircularBuffer;\nconst BufferError = circular_buffer.BufferError;\n"


def gen_case(case):
    capacity = case["input"]["capacity"]
    operations = case["input"]["operations"]

    lines = [f"    var cb = CircularBuffer(i16, {capacity}).init();\n"]
    for op in operations:
        kind = op["operation"]
        if kind == "write":
            if op["should_succeed"]:
                lines.append(f"    try cb.write({op['item']});\n")
            else:
                lines.append(
                    f"    try testing.expectError(BufferError.BufferOverflow, cb.write({op['item']}));\n"
                )
        elif kind == "read":
            if op["should_succeed"]:
                lines.append(
                    f"    try testing.expectEqual({op['expected']}, cb.read());\n"
                )
            else:
                lines.append("    try testing.expectEqual(null, cb.read());\n")
        elif kind == "overwrite":
            lines.append(f"    cb.overwrite({op['item']});\n")
        elif kind == "clear":
            lines.append("    cb.clear();\n")
    return "".join(lines)
