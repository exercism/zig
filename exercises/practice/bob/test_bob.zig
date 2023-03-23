const std = @import("std");
const testing = std.testing;

const response = @import("bob.zig").response;

test "stating something" {
    const expected = "Whatever.";
    const actual = response("Tom-ay-to, tom-aaaah-to.");
    try testing.expectEqualStrings(expected, actual);
}

test "shouting" {
    const expected = "Whoa, chill out!";
    const actual = response("WATCH OUT!");
    try testing.expectEqualStrings(expected, actual);
}

test "shouting gibberish" {
    const expected = "Whoa, chill out!";
    const actual = response("FCECDFCAAB");
    try testing.expectEqualStrings(expected, actual);
}

test "asking a question" {
    const expected = "Sure.";
    const actual = response("Does this cryogenic chamber make me look fat?");
    try testing.expectEqualStrings(expected, actual);
}

test "asking a numeric question" {
    const expected = "Sure.";
    const actual = response("You are, what, like 15?");
    try testing.expectEqualStrings(expected, actual);
}

test "asking gibberish" {
    const expected = "Sure.";
    const actual = response("fffbbcbeab?");
    try testing.expectEqualStrings(expected, actual);
}

test "talking forcefully" {
    const expected = "Whatever.";
    const actual = response("Hi there!");
    try testing.expectEqualStrings(expected, actual);
}

test "using acronyms in regular speech" {
    const expected = "Whatever.";
    const actual = response("It's OK if you don't want to go work for NASA.");
    try testing.expectEqualStrings(expected, actual);
}

test "forceful question" {
    const expected = "Calm down, I know what I'm doing!";
    const actual = response("WHAT'S GOING ON?");
    try testing.expectEqualStrings(expected, actual);
}

test "shouting numbers" {
    const expected = "Whoa, chill out!";
    const actual = response("1, 2, 3 GO!");
    try testing.expectEqualStrings(expected, actual);
}

test "no letters" {
    const expected = "Whatever.";
    const actual = response("1, 2, 3");
    try testing.expectEqualStrings(expected, actual);
}

test "question with no letters" {
    const expected = "Sure.";
    const actual = response("4?");
    try testing.expectEqualStrings(expected, actual);
}

test "shouting with special characters" {
    const expected = "Whoa, chill out!";
    const actual = response("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!");
    try testing.expectEqualStrings(expected, actual);
}

test "shouting with no exclamation mark" {
    const expected = "Whoa, chill out!";
    const actual = response("I HATE THE DENTIST");
    try testing.expectEqualStrings(expected, actual);
}

test "statement containing question mark" {
    const expected = "Whatever.";
    const actual = response("Ending with ? means a question.");
    try testing.expectEqualStrings(expected, actual);
}

test "non-letters with question" {
    const expected = "Sure.";
    const actual = response(":) ?");
    try testing.expectEqualStrings(expected, actual);
}

test "prattling on" {
    const expected = "Sure.";
    const actual = response("Wait! Hang on. Are you going to be OK?");
    try testing.expectEqualStrings(expected, actual);
}

test "silence" {
    const expected = "Fine. Be that way!";
    const actual = response("");
    try testing.expectEqualStrings(expected, actual);
}

test "prolonged silence" {
    const expected = "Fine. Be that way!";
    const actual = response("          ");
    try testing.expectEqualStrings(expected, actual);
}

test "alternate silence" {
    const expected = "Fine. Be that way!";
    const actual = response("\t\t\t\t\t\t\t\t\t\t");
    try testing.expectEqualStrings(expected, actual);
}

test "multiple line question" {
    const expected = "Whatever.";
    const actual = response("\nDoes this cryogenic chamber make me look fat?\nNo.");
    try testing.expectEqualStrings(expected, actual);
}

test "starting with whitespace" {
    const expected = "Whatever.";
    const actual = response("         hmmmmmmm...");
    try testing.expectEqualStrings(expected, actual);
}

test "ending with whitespace" {
    const expected = "Sure.";
    const actual = response("Okay if like my  spacebar  quite a bit?   ");
    try testing.expectEqualStrings(expected, actual);
}

test "other whitespace" {
    const expected = "Fine. Be that way!";
    const actual = response("\n\r \t");
    try testing.expectEqualStrings(expected, actual);
}

test "non-question ending with whitespace" {
    const expected = "Whatever.";
    const actual = response("This is a statement ending with whitespace      ");
    try testing.expectEqualStrings(expected, actual);
}
