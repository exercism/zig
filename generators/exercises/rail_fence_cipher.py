from lib import zstr, zint

USE_MEM = True
IMPORT_SELF = True

HEADER = """
const encode = rail_fence_cipher.encode;
const decode = rail_fence_cipher.decode;

const CipherFunc = *const fn (allocator: mem.Allocator, msg: []const u8, rails: u3) mem.Allocator.Error![]u8;

fn railFenceCipherTest(allocator: mem.Allocator, cipherFunc: CipherFunc, msg: []const u8, rails: u3, expected: []const u8) anyerror!void {
    const actual = try cipherFunc(allocator, msg, rails);
    defer allocator.free(actual);
    try testing.expectEqualStrings(expected, actual);
}
"""


def describe(case, parent):
    # The canonical "encode"/"decode" group names are already present in each
    # leaf description (e.g. "encode with two rails"), so drop the parent prefix.
    return case["description"]


def gen_case(case):
    prop = case["property"]  # "encode" or "decode"
    phrase = zstr(case["input"]["msg"])
    rails = zint(case["input"]["rails"])
    expect = zstr(case["expected"])
    lines = [
        f"    const phrase: []const u8 = {phrase};",
        f"    const expect: []const u8 = {expect};",
        "    try std.testing.checkAllAllocationFailures(",
        "        std.testing.allocator,",
        "        railFenceCipherTest,",
        f"        .{{ &{prop}, phrase, {rails}, expect }},",
        "    );",
    ]
    return "\n".join(lines) + "\n"
