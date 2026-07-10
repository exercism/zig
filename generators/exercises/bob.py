from lib import zstr

IMPORT_SELF = False

HEADER = """const response = @import("bob.zig").response;

fn testResponse(s: []const u8, expected: []const u8) !void {
    try testing.expectEqualStrings(expected, response(s));
}"""


def gen_case(case):
    s = case["input"]["heyBob"]
    expected = case["expected"]
    return f"    try testResponse({zstr(s)}, {zstr(expected)});\n"
