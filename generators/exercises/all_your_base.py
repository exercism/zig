from lib import zarray

IMPORT_SELF = True

# `testConvert`/`testConvertError` reduce repetition across the success and error cases, and
# - because they pass the inputs through runtime parameters - also reject a solution that
# declares `convert`'s value parameters `comptime`. (Since the whole test file compiles as a
# unit, a single such runtime path would already be enough to reject it.)
# See https://forum.exercism.org/t/zig-track-needs-tests-against-comptime-abuse-and-other-kinds-of-cheating/59830/
HEADER = """const convert = all_your_base.convert;
const ConversionError = all_your_base.ConversionError;

fn testConvert(digits: []const u32, input_base: u32, output_base: u32, expected: []const u32) !void {
    const actual = try convert(testing.allocator, digits, input_base, output_base);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, expected, actual);
}

fn testConvertError(digits: []const u32, input_base: u32, output_base: u32, expected: ConversionError) !void {
    try testing.expectError(expected, convert(testing.allocator, digits, input_base, output_base));
}
"""

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
        return f"    try testConvertError(&{digits}, {input_base}, {output_base}, {err});\n"

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

    # Single comptime-defended path (see HEADER) - routes all three inputs through runtime.
    return f"    try testConvert(&{digits}, {input_base}, {output_base}, &{expected_arr});\n"
