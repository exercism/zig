from lib import zstr

HEADER = """const buffer_size = 80;

fn testReverse(comptime s: []const u8, expected: []const u8) !void {
    var buffer: [buffer_size]u8 = undefined;
    const actual = reverse_string.reverse(&buffer, s);
    try testing.expectEqualStrings(expected, actual);
}"""


def gen_case(case):
    return f"    try testReverse({zstr(case['input']['value'])}, {zstr(case['expected'])});\n"
