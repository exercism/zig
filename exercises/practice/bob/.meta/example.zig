const isWhitespace = @import("std").ascii.isWhitespace;

fn isSilence(s: []const u8) bool {
    for (s) |c| {
        if (!isWhitespace(c)) return false;
    }
    return true;
}

/// Returns whether `s` both contains at least one uppercase letter, and does not
/// contain a lowercase letter.
fn isYelling(s: []const u8) bool {
    var result = false;
    for (s) |c| {
        switch (c) {
            'a'...'z' => return false,
            'A'...'Z' => result = true,
            else => continue,
        }
    }
    return result;
}

/// Returns whether the last non-whitespace character in `s` is the character '?'.
fn isQuestion(s: []const u8) bool {
    var i = s.len - 1;
    while (i >= 0 and isWhitespace(s[i])) {
        i -= 1;
    }
    return i >= 0 and s[i] == '?';
}

pub fn response(s: []const u8) []const u8 {
    if (isSilence(s)) {
        return "Fine. Be that way!";
    } else if (isQuestion(s)) {
        return if (isYelling(s)) "Calm down, I know what I'm doing!" else "Sure.";
    } else {
        return if (isYelling(s)) "Whoa, chill out!" else "Whatever.";
    }
}
