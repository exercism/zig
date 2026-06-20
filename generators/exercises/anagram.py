from lib import zstr

IMPORT_SELF = False

HEADER = """const detectAnagrams = @import("anagram.zig").detectAnagrams;

fn testAnagrams(
    allocator: std.mem.Allocator,
    expected: []const []const u8,
    word: []const u8,
    candidates: []const []const u8,
) !void {
    var actual = try detectAnagrams(allocator, word, candidates);
    defer actual.deinit();
    try testing.expectEqual(expected.len, actual.count());
    for (expected) |e| {
        try testing.expect(actual.contains(e));
    }
}
"""


def _strlist(values):
    if not values:
        return "[_][]const u8{}"
    inner = ", ".join(zstr(v) for v in values)
    return f"[_][]const u8{{ {inner} }}"


def gen_case(case):
    word = case["input"]["subject"]
    candidates = case["input"]["candidates"]
    expected = case["expected"]
    return (
        f"    const expected = {_strlist(expected)};\n"
        f"    const word = {zstr(word)};\n"
        f"    const candidates = {_strlist(candidates)};\n"
        f"    try std.testing.checkAllAllocationFailures(\n"
        f"        std.testing.allocator,\n"
        f"        testAnagrams,\n"
        f"        .{{ &expected, word, &candidates }},\n"
        f"    );\n"
    )
