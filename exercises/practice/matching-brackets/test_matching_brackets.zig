const std = @import("std");
const testing = std.testing;

const isBalanced = @import("matching_brackets.zig").isBalanced;

test "paired square brackets" {
    try testing.expect(isBalanced("[]"));
}

test "empty string" {
    try testing.expect(isBalanced(""));
}

test "unpaired brackets" {
    try testing.expect(!isBalanced("[["));
}

test "wrong ordered brackets" {
    try testing.expect(!isBalanced("}{"));
}

test "wrong closing bracket" {
    try testing.expect(!isBalanced("{]"));
}

test "paired with whitespace" {
    try testing.expect(isBalanced("{ }"));
}

test "partially paired brackets" {
    try testing.expect(!isBalanced("{[])"));
}

test "simple nested brackets" {
    try testing.expect(isBalanced("{[]}"));
}

test "several paired brackets" {
    try testing.expect(isBalanced("{}[]"));
}

test "paired and nested brackets" {
    try testing.expect(isBalanced("([{}({}[])])"));
}

test "unopened closing brackets" {
    try testing.expect(!isBalanced("{[)][]}"));
}

test "unpaired and nested brackets" {
    try testing.expect(!isBalanced("([{])"));
}

test "paired and wrong nested brackets" {
    try testing.expect(!isBalanced("[({]})"));
}

test "paired and wrong nested brackets but innermost are correct" {
    try testing.expect(!isBalanced("[({}])"));
}

test "paired and incomplete brackets" {
    try testing.expect(!isBalanced("{}["));
}

test "too many closing brackets" {
    try testing.expect(!isBalanced("[]]"));
}

test "early unexpected brackets" {
    try testing.expect(!isBalanced(")()"));
}

test "early mismatched brackets" {
    try testing.expect(!isBalanced("{)()"));
}

test "math expression" {
    try testing.expect(isBalanced("(((185 + 223.85) * 15) - 543)/2"));
}

test "complex latex expression" {
    const s = "\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)";
    try testing.expect(isBalanced(s));
}
