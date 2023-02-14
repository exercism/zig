const std = @import("std");
const testing = std.testing;

const response = @import("bob.zig").response;

const calm_down = "Calm down, I know what I'm doing!";
const fine = "Fine. Be that way!";
const sure = "Sure.";
const whatever = "Whatever.";
const whoa = "Whoa, chill out!";

test "stating something" {
    const actual = response("Tom-ay-to, tom-aaaah-to.");
    try testing.expectEqualStrings(whatever, actual);
}

test "shouting" {
    const actual = response("WATCH OUT!");
    try testing.expectEqualStrings(whoa, actual);
}

test "shouting gibberish" {
    const actual = response("FCECDFCAAB");
    try testing.expectEqualStrings(whoa, actual);
}

test "asking a question" {
    const actual = response("Does this cryogenic chamber make me look fat?");
    try testing.expectEqualStrings(sure, actual);
}

test "asking a numeric question" {
    const actual = response("You are, what, like 15?");
    try testing.expectEqualStrings(sure, actual);
}

test "asking gibberish" {
    const actual = response("fffbbcbeab?");
    try testing.expectEqualStrings(sure, actual);
}

test "talking forcefully" {
    const actual = response("Hi there!");
    try testing.expectEqualStrings(whatever, actual);
}

test "using acronyms in regular speech" {
    const actual = response("It's OK if you don't want to go work for NASA.");
    try testing.expectEqualStrings(whatever, actual);
}

test "forceful question" {
    const actual = response("WHAT'S GOING ON?");
    try testing.expectEqualStrings(calm_down, actual);
}

test "shouting numbers" {
    const actual = response("1, 2, 3 GO!");
    try testing.expectEqualStrings(whoa, actual);
}

test "no letters" {
    const actual = response("1, 2, 3");
    try testing.expectEqualStrings(whatever, actual);
}

test "question with no letters" {
    const actual = response("4?");
    try testing.expectEqualStrings(sure, actual);
}

test "shouting with special characters" {
    const actual = response("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!");
    try testing.expectEqualStrings(whoa, actual);
}

test "shouting with no exclamation mark" {
    const actual = response("I HATE THE DENTIST");
    try testing.expectEqualStrings(whoa, actual);
}

test "statement containing question mark" {
    const actual = response("Ending with ? means a question.");
    try testing.expectEqualStrings(whatever, actual);
}

test "non-letters with question" {
    const actual = response(":) ?");
    try testing.expectEqualStrings(sure, actual);
}

test "prattling on" {
    const actual = response("Wait! Hang on. Are you going to be OK?");
    try testing.expectEqualStrings(sure, actual);
}

test "silence" {
    const actual = response("");
    try testing.expectEqualStrings(fine, actual);
}

test "prolonged silence" {
    const actual = response("          ");
    try testing.expectEqualStrings(fine, actual);
}

test "alternate silence" {
    const actual = response("\t\t\t\t\t\t\t\t\t\t");
    try testing.expectEqualStrings(fine, actual);
}

test "multiple line question" {
    const actual = response("\nDoes this cryogenic chamber make me look fat?\nNo.");
    try testing.expectEqualStrings(whatever, actual);
}

test "starting with whitespace" {
    const actual = response("         hmmmmmmm...");
    try testing.expectEqualStrings(whatever, actual);
}

test "ending with whitespace" {
    const actual = response("Okay if like my  spacebar  quite a bit?   ");
    try testing.expectEqualStrings(sure, actual);
}

test "other whitespace" {
    const actual = response("\n\r \t");
    try testing.expectEqualStrings(fine, actual);
}

test "non-question ending with whitespace" {
    const actual = response("This is a statement ending with whitespace      ");
    try testing.expectEqualStrings(whatever, actual);
}
