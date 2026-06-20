from lib import zstr, is_error, zcomment_list

# The canonical error cases are expressed as "expect an empty result" rather than `expectError`.
#
# Two uuids are excluded via `include = false` in tests.toml:
#   10ab822d-... "slice length cannot be negative" (track-specific)
#   d34004ad-... "slice length cannot be zero"      -- slice_length is comptime and the
#       example asserts slice_length > 0 at comptime, so a 0-length call cannot compile.
IMPORT_SELF = False

HEADER = 'const slices = @import("series.zig").slices;\n'


def gen_case(case):
    inp = case["input"]
    series_str = inp["series"]
    n = inp["sliceLength"]
    expected = case["expected"]

    if is_error(expected):
        # Example returns an empty result for over-long slice lengths / empty series.
        return (
            f"    const series = {zstr(series_str)};\n"
            f"    const expected = [_][{n}]u8{{}};\n"
            f"    const actual = try slices({n}, testing.allocator, series);\n"
            f"    defer testing.allocator.free(actual);\n"
            f"    try testing.expectEqualSlices([{n}]u8, &expected, actual);\n"
        )

    # One slice per line (with trailing `//`) so the expected series stays readable.
    elems = zcomment_list([f"{zstr(s)}[0..{n}].*" for s in expected])
    return (
        f"    const series = {zstr(series_str)};\n"
        f"    const expected = [_][{n}]u8{elems};\n"
        f"    const actual = try slices({n}, testing.allocator, series);\n"
        f"    defer testing.allocator.free(actual);\n"
        f"    try testing.expectEqualSlices([{n}]u8, &expected, actual);\n"
    )
