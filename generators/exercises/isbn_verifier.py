from lib import zstr

IMPORT_SELF = False
HEADER = 'const isValidIsbn10 = @import("isbn_verifier.zig").isValidIsbn10;'


def describe(case, parent):
    # Canonical descriptions spell it "isbn"; the track wants "ISBN".
    desc = case["description"]
    if parent:
        desc = f"{parent}-{desc}"
    return desc.replace("isbn", "ISBN")


def gen_case(case):
    isbn = case["input"]["isbn"]
    expected = case["expected"]
    call = f"isValidIsbn10({zstr(isbn)})"
    if expected:
        return f"    try testing.expect({call});\n"
    return f"    try testing.expect(!{call});\n"
