IMPORT_SELF = False

# Dice and category are passed through `testScore`'s runtime parameters, so a solution that
# declares `score`'s parameters `comptime` is rejected at compile time.
# See https://forum.exercism.org/t/zig-track-needs-tests-against-comptime-abuse-and-other-kinds-of-cheating/59830/
HEADER = """const score = @import("yacht.zig").score;
const Category = @import("yacht.zig").Category;

fn testScore(dice: [5]u3, category: Category, expected: u32) !void {
    try testing.expectEqual(expected, score(dice, category));
}
"""

# Scoring categories, in the order of the `Category` enum in the solution.
CATEGORIES = [
    "ones",
    "twos",
    "threes",
    "fours",
    "fives",
    "sixes",
    "full_house",
    "four_of_a_kind",
    "little_straight",
    "big_straight",
    "choice",
    "yacht",
]


def _category(case):
    return case["input"]["category"].replace(" ", "_")


def describe(case, parent):
    return case["description"].lower()


def order_key(case):
    return (CATEGORIES.index(_category(case)), case["description"].lower())


def gen_case(case):
    dice = ", ".join(str(d) for d in case["input"]["dice"])
    category = _category(case)
    expected = case["expected"]
    return f"    try testScore([_]u3{{ {dice} }}, .{category}, {expected});\n"
