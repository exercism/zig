from lib import zint, is_error

USE_MEM = True

HEADER = """const SayError = say.SayError;

fn sayTest(allocator: mem.Allocator, number: i41, expected: []const u8) anyerror!void {
    const actual = try say.say(allocator, number);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}"""


def gen_case(case):
    number = case["input"]["number"]
    expected = case["expected"]
    if is_error(expected):
        return (
            f"    try testing.expectError(SayError.OutOfRange, "
            f"say.say(testing.allocator,{zint(number)}));\n"
        )
    return (
        "    try testing.checkAllAllocationFailures(\n"
        "        testing.allocator,\n"
        "        sayTest,\n"
        f'        .{{ {zint(number)}, "{expected}" }},\n'
        "    );\n"
    )
