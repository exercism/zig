from lib import zstr, is_error

HEADER = "const answer = wordy.answer;\nconst ArgumentError = wordy.ArgumentError;\n"

# Canonical error message -> ArgumentError
_ERROR_MAP = {
    "unknown operation": "UnsupportedQuestion",
    "syntax error": "SyntaxError",
    "division by zero": "DivisionByZero",
}


def gen_case(case):
    question = case["input"]["question"]
    expected = case["expected"]
    q = zstr(question)
    if is_error(expected):
        variant = _ERROR_MAP[expected["error"]]
        return f"    try testing.expectError(ArgumentError.{variant}, answer({q}));\n"
    return f"    try testing.expectEqual({expected}, answer({q}));\n"
