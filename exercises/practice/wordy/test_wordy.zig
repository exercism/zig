const std = @import("std");
const testing = std.testing;

const wordy = @import("wordy.zig");
const answer = wordy.answer;
const ArgumentError = wordy.ArgumentError;

test "just a number" {
    try testing.expectEqual(5, answer("What is 5?"));
}

test "just a zero" {
    try testing.expectEqual(0, answer("What is 0?"));
}

test "just a negative number" {
    try testing.expectEqual(-123, answer("What is -123?"));
}

test "addition" {
    try testing.expectEqual(2, answer("What is 1 plus 1?"));
}

test "addition with a left hand zero" {
    try testing.expectEqual(2, answer("What is 0 plus 2?"));
}

test "addition with a right hand zero" {
    try testing.expectEqual(3, answer("What is 3 plus 0?"));
}

test "more addition" {
    try testing.expectEqual(55, answer("What is 53 plus 2?"));
}

test "addition with negative numbers" {
    try testing.expectEqual(-11, answer("What is -1 plus -10?"));
}

test "large addition" {
    try testing.expectEqual(45801, answer("What is 123 plus 45678?"));
}

test "subtraction" {
    try testing.expectEqual(16, answer("What is 4 minus -12?"));
}

test "multiplication" {
    try testing.expectEqual(-75, answer("What is -3 multiplied by 25?"));
}

test "division" {
    try testing.expectEqual(-11, answer("What is 33 divided by -3?"));
}

test "multiple additions" {
    try testing.expectEqual(3, answer("What is 1 plus 1 plus 1?"));
}

test "addition and subtraction" {
    try testing.expectEqual(8, answer("What is 1 plus 5 minus -2?"));
}

test "multiple subtraction" {
    try testing.expectEqual(3, answer("What is 20 minus 4 minus 13?"));
}

test "subtraction then addition" {
    try testing.expectEqual(14, answer("What is 17 minus 6 plus 3?"));
}

test "multiple multiplication" {
    try testing.expectEqual(-12, answer("What is 2 multiplied by -2 multiplied by 3?"));
}

test "addition and multiplication" {
    try testing.expectEqual(-8, answer("What is -3 plus 7 multiplied by -2?"));
}

test "multiple division" {
    try testing.expectEqual(2, answer("What is -12 divided by 2 divided by -3?"));
}

test "unknown operation" {
    try testing.expectError(ArgumentError.UnknownOperation, answer("What is 52 cubed?"));
}

test "Non math question" {
    try testing.expectError(ArgumentError.UnknownOperation, answer("Who is the President of the United States?"));
}

test "reject problem missing an operand" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is 1 plus?"));
}

test "reject problem with no operands or operators" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is?"));
}

test "reject two operations in a row" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is 1 plus plus 2?"));
}

test "reject two numbers in a row" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is 1 plus 2 1?"));
}

test "reject postfix notation" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is 1 2 plus?"));
}

test "reject prefix notation" {
    try testing.expectError(ArgumentError.SyntaxError, answer("What is plus 1 2?"));
}

test "reject division by zero" {
    try testing.expectError(ArgumentError.DivisionByZero, answer("What is 76543 divided by 0?"));
}
