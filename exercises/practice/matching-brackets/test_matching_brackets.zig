const std = @import("std");
const testing = std.testing;

const isPaired = @import("matching_brackets.zig").isPaired;

test "paired square brackets" {
    try testing.expect(isPaired("[]"));
}

test "empty string" {
    try testing.expect(isPaired(""));
}

test "unpaired brackets" {
    try testing.expect(!isPaired("[["));
}

test "wrong ordered brackets" {
    try testing.expect(!isPaired("}{"));
}

test "wrong closing bracket" {
    try testing.expect(!isPaired("{]"));
}

test "paired with whitespace" {
    try testing.expect(isPaired("{ }"));
}

test "partially paired brackets" {
    try testing.expect(!isPaired("{[])"));
}

test "simple nested brackets" {
    try testing.expect(isPaired("{[]}"));
}

test "several paired brackets" {
    try testing.expect(isPaired("{}[]"));
}

test "paired and nested brackets" {
    try testing.expect(isPaired("([{}({}[])])"));
}

test "unopened closing brackets" {
    try testing.expect(!isPaired("{[)][]}"));
}

test "unpaired and nested brackets" {
    try testing.expect(!isPaired("([{])"));
}

test "paired and wrong nested brackets" {
    try testing.expect(!isPaired("[({]})"));
}

test "paired and wrong nested brackets but innermost are correct" {
    try testing.expect(!isPaired("[({}])"));
}

test "paired and incomplete brackets" {
    try testing.expect(!isPaired("{}["));
}

test "too many closing brackets" {
    try testing.expect(!isPaired("[]]"));
}

test "early unexpected brackets" {
    try testing.expect(!isPaired(")()"));
}

test "early mismatched brackets" {
    try testing.expect(!isPaired("{)()"));
}

test "math expression" {
    try testing.expect(isPaired("(((185 + 223.85) * 15) - 543)/2"));
}

test "complex latex expression" {
    const s = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)";
    try testing.expect(isPaired(s));
}
