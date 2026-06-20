from lib import zint

IMPORT_SELF = False

# The number is passed through `testIsArmstrongNumber`'s runtime parameter, so a solution
# that declares `isArmstrongNumber`'s parameter `comptime` is rejected at compile time.
# See https://forum.exercism.org/t/zig-track-needs-tests-against-comptime-abuse-and-other-kinds-of-cheating/59830/
HEADER = """const isArmstrongNumber = @import("armstrong_numbers.zig").isArmstrongNumber;

fn testIsArmstrongNumber(number: u128, expected: bool) !void {
    try testing.expectEqual(expected, isArmstrongNumber(number));
}
"""


def gen_case(case):
    number = zint(case["input"]["number"])
    expected = "true" if case["expected"] else "false"
    return f"    try testIsArmstrongNumber({number}, {expected});\n"
