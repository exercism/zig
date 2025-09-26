const std = @import("std");
const testing = std.testing;

const ocr_numbers = @import("ocr_numbers.zig");
const convert = ocr_numbers.convert;
const RecognitionError = ocr_numbers.RecognitionError;

const buffer_size = 80;

test "Recognizes 0" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "| |", //
        "|_|", //
        "   ", //
    };
    try testing.expectEqualStrings("0", try convert(&buffer, &input));
}

test "Recognizes 1" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "   ", //
        "  |", //
        "  |", //
        "   ", //
    };
    try testing.expectEqualStrings("1", try convert(&buffer, &input));
}

test "Unreadable but correctly sized inputs return ?" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "   ", //
        "  _", //
        "  |", //
        "   ", //
    };
    try testing.expectEqualStrings("?", try convert(&buffer, &input));
}

test "Input with a number of lines that is not a multiple of four raises an error" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "| |", //
        "   ", //
    };
    try testing.expectError(RecognitionError.InvalidRowCount, convert(&buffer, &input));
}

test "Input with a number of columns that is not a multiple of three raises an error" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "    ", //
        "   |", //
        "   |", //
        "    ", //
    };
    try testing.expectError(RecognitionError.InvalidColumnCount, convert(&buffer, &input));
}

test "Recognizes 110101100" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "       _     _        _  _ ", //
        "  |  || |  || |  |  || || |", //
        "  |  ||_|  ||_|  |  ||_||_|", //
        "                           ", //
    };
    try testing.expectEqualStrings("110101100", try convert(&buffer, &input));
}

test "Garbled numbers in a string are replaced with ?" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "       _     _           _ ", //
        "  |  || |  || |     || || |", //
        "  |  | _|  ||_|  |  ||_||_|", //
        "                           ", //
    };
    try testing.expectEqualStrings("11?10?1?0", try convert(&buffer, &input));
}

test "Recognizes 2" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        " _|", //
        "|_ ", //
        "   ", //
    };
    try testing.expectEqualStrings("2", try convert(&buffer, &input));
}

test "Recognizes 3" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        " _|", //
        " _|", //
        "   ", //
    };
    try testing.expectEqualStrings("3", try convert(&buffer, &input));
}

test "Recognizes 4" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "   ", //
        "|_|", //
        "  |", //
        "   ", //
    };
    try testing.expectEqualStrings("4", try convert(&buffer, &input));
}

test "Recognizes 5" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "|_ ", //
        " _|", //
        "   ", //
    };
    try testing.expectEqualStrings("5", try convert(&buffer, &input));
}

test "Recognizes 6" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "|_ ", //
        "|_|", //
        "   ", //
    };
    try testing.expectEqualStrings("6", try convert(&buffer, &input));
}

test "Recognizes 7" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "  |", //
        "  |", //
        "   ", //
    };
    try testing.expectEqualStrings("7", try convert(&buffer, &input));
}

test "Recognizes 8" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "|_|", //
        "|_|", //
        "   ", //
    };
    try testing.expectEqualStrings("8", try convert(&buffer, &input));
}

test "Recognizes 9" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        " _ ", //
        "|_|", //
        " _|", //
        "   ", //
    };
    try testing.expectEqualStrings("9", try convert(&buffer, &input));
}

test "Recognizes string of decimal numbers" {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "    _  _     _  _  _  _  _  _ ", //
        "  | _| _||_||_ |_   ||_||_|| |", //
        "  ||_  _|  | _||_|  ||_| _||_|", //
        "                              ", //
    };
    try testing.expectEqualStrings("1234567890", try convert(&buffer, &input));
}

test "Numbers separated by empty lines are recognized. Lines are joined by commas." {
    var buffer: [buffer_size]u8 = undefined;
    const input = [_][]const u8{
        "    _  _ ", //
        "  | _| _|", //
        "  ||_  _|", //
        "         ", //
        "    _  _ ", //
        "|_||_ |_ ", //
        "  | _||_|", //
        "         ", //
        " _  _  _ ", //
        "  ||_||_|", //
        "  ||_| _|", //
        "         ", //
    };
    try testing.expectEqualStrings("123,456,789", try convert(&buffer, &input));
}
