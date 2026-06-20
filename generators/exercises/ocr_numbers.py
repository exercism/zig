from lib import zstr, is_error

HEADER = """const convert = ocr_numbers.convert;
const RecognitionError = ocr_numbers.RecognitionError;

const buffer_size = 80;
"""

_ERRORS = {
    "Number of input lines is not a multiple of four": "InvalidRowCount",
    "Number of input columns is not a multiple of three": "InvalidColumnCount",
}


def gen_case(case):
    rows = case["input"]["rows"]
    expected = case["expected"]
    lines = "".join(f"        {zstr(r)}, //\n" for r in rows)
    body = (
        "    var buffer: [buffer_size]u8 = undefined;\n"
        "    const input = [_][]const u8{\n"
        f"{lines}"
        "    };\n"
    )
    if is_error(expected):
        err = _ERRORS[expected["error"]]
        body += (
            f"    try testing.expectError(RecognitionError.{err}, "
            "convert(&buffer, &input));\n"
        )
    else:
        body += (
            f"    try testing.expectEqualStrings({zstr(expected)}, "
            "try convert(&buffer, &input));\n"
        )
    return body
