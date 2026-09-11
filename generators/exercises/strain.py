from lib import zstr

HEADER = """const keep = strain.keep;
const discard = strain.discard;

fn alwaysTrue(_: u32) bool {
    return true;
}

fn alwaysFalse(_: u32) bool {
    return false;
}

fn isOdd(x: u32) bool {
    return x % 2 == 1;
}

fn isEven(x: u32) bool {
    return x % 2 == 0;
}

fn startsWithZ(x: []const u8) bool {
    return std.mem.startsWith(u8, x, "z");
}

fn containsFive(x: []const u32) bool {
    return std.mem.indexOfScalar(u32, x, 5) != null;
}

/// Binds an element type and a predicate, providing allocation-checked
/// wrappers around `keep` and `discard`.
fn Case(comptime T: type, comptime predicate: fn (T) bool) type {
    return struct {
        fn expectEqualElements(expected: T, actual: T) !void {
            if (comptime T == []const u8) {
                try testing.expectEqualStrings(expected, actual);
            } else if (comptime T == []const u32) {
                try testing.expectEqualSlices(u32, expected, actual);
            } else {
                try testing.expectEqual(expected, actual);
            }
        }

        fn testKeep(allocator: std.mem.Allocator, list: []const T, expected: []const T) !void {
            const actual = try keep(T, allocator, list, predicate);
            defer allocator.free(actual);
            try testing.expectEqual(expected.len, actual.len);
            for (expected, actual) |e, a| try expectEqualElements(e, a);
        }

        fn testDiscard(allocator: std.mem.Allocator, list: []const T, expected: []const T) !void {
            const actual = try discard(T, allocator, list, predicate);
            defer allocator.free(actual);
            try testing.expectEqual(expected.len, actual.len);
            for (expected, actual) |e, a| try expectEqualElements(e, a);
        }
    };
}
"""

PREDICATES = {
    "fn(x) -> true": "alwaysTrue",
    "fn(x) -> false": "alwaysFalse",
    "fn(x) -> x % 2 == 1": "isOdd",
    "fn(x) -> x % 2 == 0": "isEven",
    "fn(x) -> starts_with(x, 'z')": "startsWithZ",
    "fn(x) -> contains(x, 5)": "containsFive",
}


def element(v):
    if isinstance(v, str):
        return zstr(v)
    if isinstance(v, list):
        return "&.{ " + ", ".join(str(x) for x in v) + " }"
    return str(v)


def array(values, zig_type):
    if not values:
        return f"[_]{zig_type}{{}}"
    return f"[_]{zig_type}{{ " + ", ".join(element(v) for v in values) + " }"


def gen_case(case):
    inp = case["input"]
    lst = inp["list"]
    predicate = PREDICATES[inp["predicate"]]

    if lst and isinstance(lst[0], str):
        zig_type = "[]const u8"
    elif lst and isinstance(lst[0], list):
        zig_type = "[]const u32"
    else:
        zig_type = "u32"

    fn = "testKeep" if case["property"] == "keep" else "testDiscard"
    return (
        f"    const list = {array(lst, zig_type)};\n"
        f"    const expected = {array(case['expected'], zig_type)};\n"
        "    try testing.checkAllAllocationFailures(\n"
        "        testing.allocator,\n"
        f"        Case({zig_type}, {predicate}).{fn},\n"
        "        .{ &list, &expected },\n"
        "    );\n"
    )
