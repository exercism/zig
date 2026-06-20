from lib import zstr

HEADER = """
fn testEncode(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer: [buffer_size]u8 = undefined;
    const actual = run_length_encoding.encode(&buffer, string);
    try testing.expectEqualStrings(expected, actual);
}

fn testDecode(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer: [buffer_size]u8 = undefined;
    const actual = run_length_encoding.decode(&buffer, string);
    try testing.expectEqualStrings(expected, actual);
}

fn testConsistency(string: []const u8, expected: []const u8) !void {
    const buffer_size = 80;
    var buffer1: [buffer_size]u8 = undefined;
    var buffer2: [buffer_size]u8 = undefined;
    const encoded = run_length_encoding.encode(&buffer1, string);
    const actual = run_length_encoding.decode(&buffer2, encoded);
    try testing.expectEqualStrings(expected, actual);
}
"""

_FN = {
    "encode": "testEncode",
    "decode": "testDecode",
    "consistency": "testConsistency",
}


def gen_case(case):
    string = zstr(case["input"]["string"])
    expected = zstr(case["expected"])
    fn = _FN[case["property"]]
    return f"    try {fn}({string}, {expected});\n"
