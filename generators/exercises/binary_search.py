from lib import zarray

IMPORT_SELF = True

# Inputs are passed through `testBinarySearch`'s runtime parameters, so a solution that
# declares `binarySearch`'s value parameters `comptime` is rejected at compile time.
# See https://forum.exercism.org/t/zig-track-needs-tests-against-comptime-abuse-and-other-kinds-of-cheating/59830/
HEADER = """
fn testBinarySearch(comptime T: type, target: T, items: []const T, expected: ?usize) !void {
    try testing.expectEqual(expected, binary_search.binarySearch(T, target, items));
}
"""

# The committed target cycles a different integer type through each case, in order.
_TYPE_BY_DESC = {
    "finds a value in an array with one element": "i4",
    "finds a value in the middle of an array": "u4",
    "finds a value at the beginning of an array": "i8",
    "finds a value at the end of an array": "u8",
    "finds a value in an array of odd length": "i16",
    "finds a value in an array of even length": "u16",
    "identifies that a value is not included in the array": "i32",
    "a value smaller than the array's smallest value is not found": "u32",
    "a value larger than the array's largest value is not found": "i64",
    "nothing is found in an empty array": "u64",
    "nothing is found when the left and right bounds cross": "isize",
}

_ORDER = list(_TYPE_BY_DESC.keys())

# The committed target searches for 13 in the not-found "empty array" and
# "bounds cross" cases (canonical uses 1 and 0 respectively).
_VALUE_OVERRIDE = {
    "nothing is found in an empty array": 13,
    "nothing is found when the left and right bounds cross": 13,
}


def order_key(case):
    try:
        return _ORDER.index(case["description"])
    except ValueError:
        return len(_ORDER)


def gen_case(case):
    desc = case["description"]
    ty = _TYPE_BY_DESC[desc]
    inp = case["input"]
    array = zarray([str(v) for v in inp["array"]], ty)
    value = _VALUE_OVERRIDE.get(desc, inp["value"])
    expected = case["expected"]

    if isinstance(expected, dict) and "error" in expected:
        idx = "null"
    else:
        idx = str(expected)

    return f"    try testBinarySearch({ty}, {value}, &{array}, {idx});\n"
