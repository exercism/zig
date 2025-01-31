const std = @import("std");
const mem = std.mem;

pub fn translate(allocator: mem.Allocator, phrase: []const u8) mem.Allocator.Error![]u8 {
    var numWords: usize = 1;
    for (phrase, 0..) |ch, i| {
        _ = i;
        if (ch == ' ') {
            numWords += 1;
        }
    }
    const result = try allocator.alloc(u8, phrase.len + 2 * numWords);
    var outIndex: usize = 0;
    var startIndex: usize = 0;

    while (startIndex < phrase.len) {
        var midIndex: usize = startIndex;

        var ch = phrase[startIndex];
        if (startIndex + 1 < phrase.len and
            ch != 'a' and
            ch != 'e' and
            ch != 'i' and
            ch != 'o' and
            ch != 'u' and
            (ch != 'x' or phrase[startIndex + 1] != 'r') and
            (ch != 'y' or phrase[startIndex + 1] != 't')) {

            var prev = ch;
            midIndex += 1;
            ch = phrase[midIndex];
            while (midIndex < phrase.len and
                   ch != ' ' and
                   ch != 'a' and
                   ch != 'e' and
                   ch != 'i' and
                   ch != 'o' and
                   ch != 'u' and
                   ch != 'y') {
                prev = ch;
                midIndex += 1;
                ch = phrase[midIndex];
            }
            if (prev == 'q' and ch == 'u') {
                midIndex += 1;
            }
        }

        var endIndex = midIndex;
        while (endIndex < phrase.len and phrase[endIndex] != ' ') {
            endIndex += 1;
        }

        @memcpy(result[outIndex..(outIndex + endIndex - midIndex)], phrase[midIndex..endIndex]);
        outIndex += endIndex - midIndex;
        @memcpy(result[outIndex..(outIndex + midIndex - startIndex)], phrase[startIndex..midIndex]);
        outIndex += midIndex - startIndex;
        @memcpy(result[outIndex..(outIndex + 2)], "ay");
        outIndex += 2;
        startIndex = endIndex;

        if (startIndex < phrase.len) {
            result[outIndex] = ' ';
            startIndex += 1;
            outIndex += 1;
        }
    }

    return result;
}
