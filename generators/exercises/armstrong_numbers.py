from lib import zint

IMPORT_SELF = False
HEADER = 'const isArmstrongNumber = @import("armstrong_numbers.zig").isArmstrongNumber;'

# The track test file uses its own (lower-cased, digit-count-based) descriptions
# that differ from canonical-data, so remap by uuid. Supplement cases supply their
# own `description` and are not in this table.
_DESC = {
    "c1ed103c-258d-45b2-be73-d8c6d9580c7b": "zero is an armstrong number",
    "579e8f03-9659-4b85-a1a2-d64350f6b17a": "single-digit numbers are armstrong numbers",
    "2d6db9dc-5bf8-4976-a90b-b2c2b9feba60": "there are no two-digit armstrong numbers",
    "509c087f-e327-4113-a7d2-26a4e9d18283": "three-digit number that is an armstrong number",
    "7154547d-c2ce-468d-b214-4cb953b870cf": "three-digit number that is not an armstrong number",
    "6bac5b7b-42e9-4ecb-a8b0-4832229aa103": "four-digit number that is an armstrong number",
    "eed4b331-af80-45b5-a80b-19c9ea444b2e": "four-digit number that is not an armstrong number",
    "f971ced7-8d68-4758-aea1-d4194900b864": "seven-digit number that is an armstrong number",
    "7ee45d52-5d35-4fbd-b6f1-5c8cd8a67f18": "seven-digit number that is not an armstrong number",
    "5ee2fdf8-334e-4a46-bb8d-e5c19c02c148": "33-digit number that is an armstrong number",
    "12ffbf10-307a-434e-b4ad-c925680e1dd4": "the largest and last armstrong number",
}


def describe(case, parent):
    return _DESC.get(case.get("uuid"), case["description"])


# Supplements always append after canonical cases; reorder so the two big-integer
# "not an armstrong number" supplements land next to their canonical neighbours.
_ORDER = [
    "zero is an armstrong number",
    "single-digit numbers are armstrong numbers",
    "there are no two-digit armstrong numbers",
    "three-digit number that is an armstrong number",
    "three-digit number that is not an armstrong number",
    "four-digit number that is an armstrong number",
    "four-digit number that is not an armstrong number",
    "seven-digit number that is an armstrong number",
    "seven-digit number that is not an armstrong number",
    "33-digit number that is an armstrong number",
    "38-digit number that is not an armstrong number",
    "the largest and last armstrong number",
    "the largest 128-bit unsigned integer value is not an armstrong number",
]


def order_key(case):
    return _ORDER.index(case["description"])


def gen_case(case):
    number = zint(case["input"]["number"])
    bang = "" if case["expected"] else "!"
    return f"    try testing.expect({bang}isArmstrongNumber({number}));\n"
