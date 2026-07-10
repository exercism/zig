const std = @import("std");
const testing = std.testing;

const response = @import("bob.zig").response;

fn testResponse(s: []const u8, expected: []const u8) !void {
    try testing.expectEqualStrings(expected, response(s));
}

test "asking a question" {
    try testResponse("Does this cryogenic chamber make me look fat?", "Sure.");
}

test "shouting" {
    try testResponse("WATCH OUT!", "Whoa, chill out!");
}

test "forceful question" {
    try testResponse("WHAT'S GOING ON?", "Calm down, I know what I'm doing!");
}

test "silence" {
    try testResponse("", "Fine. Be that way!");
}

test "stating something" {
    try testResponse("Tom-ay-to, tom-aaaah-to.", "Whatever.");
}

test "asking a numeric question" {
    try testResponse("You are, what, like 15?", "Sure.");
}

test "asking gibberish" {
    try testResponse("fffbbcbeab?", "Sure.");
}

test "question with no letters" {
    try testResponse("4?", "Sure.");
}

test "non-letters with question" {
    try testResponse(":) ?", "Sure.");
}

test "prattling on" {
    try testResponse("Wait! Hang on. Are you going to be OK?", "Sure.");
}

test "ending with whitespace" {
    try testResponse("Okay if like my  spacebar  quite a bit?   ", "Sure.");
}

test "multiple line question" {
    try testResponse("\nDoes this cryogenic chamber make\n me look fat?", "Sure.");
}

test "shouting gibberish" {
    try testResponse("FCECDFCAAB", "Whoa, chill out!");
}

test "shouting a statement containing a question mark" {
    try testResponse("DO LIONS EAT PEOPLE? AHHHHH.", "Whoa, chill out!");
}

test "shouting numbers" {
    try testResponse("1, 2, 3 GO!", "Whoa, chill out!");
}

test "shouting with special characters" {
    try testResponse("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!", "Whoa, chill out!");
}

test "shouting with no exclamation mark" {
    try testResponse("I HATE THE DENTIST", "Whoa, chill out!");
}

test "prolonged silence" {
    try testResponse("          ", "Fine. Be that way!");
}

test "alternate silence" {
    try testResponse("\t\t\t\t\t\t\t\t\t\t", "Fine. Be that way!");
}

test "other whitespace" {
    try testResponse("\n\r \t", "Fine. Be that way!");
}

test "talking forcefully" {
    try testResponse("Hi there!", "Whatever.");
}

test "using acronyms in regular speech" {
    try testResponse("It's OK if you don't want to go work for NASA.", "Whatever.");
}

test "no letters" {
    try testResponse("1, 2, 3", "Whatever.");
}

test "statement containing question mark" {
    try testResponse("Ending with ? means a question.", "Whatever.");
}

test "starting with whitespace" {
    try testResponse("         hmmmmmmm...", "Whatever.");
}

test "non-question ending with whitespace" {
    try testResponse("This is a statement ending with whitespace      ", "Whatever.");
}
