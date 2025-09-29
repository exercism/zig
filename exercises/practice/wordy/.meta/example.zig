const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub const Operation = enum {
    plus,
    minus,
    multiplied_by,
    divided_by,
};

fn consumeWord(iter: *mem.SplitIterator(u8, .scalar), word: []const u8) bool {
    if (iter.peek()) |slice| {
        if (mem.eql(u8, slice, word)) {
            _ = iter.next();
            return true;
        }
        return false;
    }
    return false;
}

fn consumeInt(iter: *mem.SplitIterator(u8, .scalar)) ?i32 {
    if (iter.peek()) |slice| {
        const number = fmt.parseInt(i32, slice, 10) catch {
            return null;
        };
        _ = iter.next();
        return number;
    }
    return null;
}

pub fn answer(question: []const u8) ?i32 {
    if (question.len == 0 or question[question.len - 1] != '?') {
        return null;
    }

    var iter = mem.splitScalar(u8, question[0..(question.len - 1)], ' ');

    if (!consumeWord(&iter, "What")) {
        return null;
    }

    if (!consumeWord(&iter, "is")) {
        return null;
    }

    var first = consumeInt(&iter) orelse return null;
    while (iter.peek() != null) {
        const operation: Operation = if (consumeWord(&iter, "plus"))
            .plus
        else if (consumeWord(&iter, "minus"))
            .minus
        else if (consumeWord(&iter, "multiplied"))
            .multiplied_by
        else if (consumeWord(&iter, "divided"))
            .divided_by
        else {
            return null;
        };

        if (operation == .multiplied_by or operation == .divided_by) {
            if (!consumeWord(&iter, "by")) {
                return null;
            }
        }

        const second = consumeInt(&iter) orelse return null;

        if (operation == .divided_by and second == 0) {
            return null;
        }

        first = switch (operation) {
            .plus => first + second,
            .minus => first - second,
            .multiplied_by => first * second,
            .divided_by => @divTrunc(first, second),
        };
    }
    return first;
}
