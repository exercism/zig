from lib import zarray

IMPORT_SELF = True
HEADER = (
    "const convert = all_your_base.convert;\n"
    "const ConversionError = all_your_base.ConversionError;\n"
)

_ERROR_FOR = {
    "input base must be >= 2": "ConversionError.InvalidInputBase",
    "output base must be >= 2": "ConversionError.InvalidOutputBase",
    "all digits must satisfy 0 <= d < input base": "ConversionError.InvalidDigit",
}

_SECOND_CALL = "empty list - second call returns different memory"

# The committed target inserts the track-specific "second call" supplement between
# "15-bit integer" and "empty list"; canonical cases otherwise keep their order.
_ORDER = [
    "single bit one to decimal",
    "binary to single decimal",
    "single decimal to binary",
    "binary to multiple decimal",
    "decimal to binary",
    "trinary to hexadecimal",
    "hexadecimal to trinary",
    "15-bit integer",
    _SECOND_CALL,
    "empty list",
    "single zero",
    "multiple zeros",
    "leading zeros",
    "input base is one",
    "input base is zero",
    "invalid positive digit",
    "output base is one",
    "output base is zero",
]


def order_key(case):
    try:
        return _ORDER.index(case["description"])
    except ValueError:
        return len(_ORDER)


def _u32_array(values):
    return zarray([str(v) for v in values], "u32")


def gen_case(case):
    inp = case["input"]
    digits = _u32_array(inp["digits"])
    input_base = inp["inputBase"]
    output_base = inp["outputBase"]
    expected = case["expected"]

    if isinstance(expected, dict) and "error" in expected:
        err = _ERROR_FOR[expected["error"]]
        return (
            f"    const expected = {err};\n"
            f"    const digits = {digits};\n"
            f"    const input_base = {input_base};\n"
            f"    const output_base = {output_base};\n"
            "    const actual = convert(testing.allocator, &digits, input_base, output_base);\n"
            "    try testing.expectError(expected, actual);\n"
        )

    expected_arr = _u32_array(expected)

    if case["description"] == _SECOND_CALL:
        return (
            "    // The `convert` doc comment says that the caller owns the returned memory.\n"
            "    // `convert` must always return memory that can be freed.\n"
            "    // Test that `convert` does not return a slice that references a global array.\n"
            f"    const expected = {expected_arr};\n"
            f"    const digits = {digits};\n"
            f"    const input_base = {input_base};\n"
            f"    const output_base = {output_base};\n"
            "    const actual = try convert(testing.allocator, &digits, input_base, output_base);\n"
            "    defer testing.allocator.free(actual);\n"
            "    try testing.expectEqualSlices(u32, &expected, actual);\n"
            "    actual[0] = 1; // Modify the output!\n"
            "    const again = try convert(testing.allocator, &digits, input_base, output_base);\n"
            "    defer testing.allocator.free(again);\n"
            "    try testing.expectEqualSlices(u32, &expected, again);\n"
        )

    return (
        f"    const expected = {expected_arr};\n"
        f"    const digits = {digits};\n"
        f"    const input_base = {input_base};\n"
        f"    const output_base = {output_base};\n"
        "    const actual = try convert(testing.allocator, &digits, input_base, output_base);\n"
        "    defer testing.allocator.free(actual);\n"
        "    try testing.expectEqualSlices(u32, &expected, actual);\n"
    )
