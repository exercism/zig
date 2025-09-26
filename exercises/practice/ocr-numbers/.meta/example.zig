const std = @import("std");

pub const RecognitionError = error{
    InvalidRowCount,
    InvalidColumnCount,
};

const digits = [_][4][]const u8{
    [4][]const u8{
        " _ ", //
        "| |", // 0
        "|_|", //
        "   ", //
    },
    [4][]const u8{
        "   ", //
        "  |", // 1
        "  |", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        " _|", // 2
        "|_ ", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        " _|", // 3
        " _|", //
        "   ", //
    },
    [4][]const u8{
        "   ", //
        "|_|", // 4
        "  |", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        "|_ ", // 5
        " _|", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        "|_ ", // 6
        "|_|", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        "  |", // 7
        "  |", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        "|_|", // 8
        "|_|", //
        "   ", //
    },
    [4][]const u8{
        " _ ", //
        "|_|", // 9
        " _|", //
        "   ", //
    },
};

fn match(input: []const []const u8, i: usize, j: usize, digit: []const []const u8) bool {
    return for (0..4) |line| {
        if (!std.mem.eql(u8, input[i + line][j..(j + 3)], digit[line])) {
            break false;
        }
    } else true;
}

pub fn convert(buffer: []u8, input: []const []const u8) RecognitionError![]u8 {
    if (input.len == 0) {
        return "";
    }
    if (input.len % 4 != 0) {
        return RecognitionError.InvalidRowCount;
    }
    if (input[0].len % 3 != 0) {
        return RecognitionError.InvalidColumnCount;
    }

    var index: usize = 0;
    var i: usize = 0;
    while (i < input.len) : (i += 4) {
        if (i != 0) {
            buffer[index] = ',';
            index += 1;
        }
        var j: usize = 0;
        while (j < input[0].len) : (j += 3) {
            buffer[index] = for (0..10) |number| {
                if (match(input, i, j, &digits[number])) {
                    break @as(u8, @intCast('0' + number));
                }
            } else '?';
            index += 1;
        }
    }
    return buffer[0..index];
}
