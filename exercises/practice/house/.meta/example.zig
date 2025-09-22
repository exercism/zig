const std = @import("std");

const lyrics = "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";

const this_is_len: usize = 8;

const table = [_]usize{ 0, 389, 368, 351, 331, 310, 267, 232, 190, 145, 99, 62, 8 };

fn appendString(buffer: []u8, offset: *usize, str: []const u8) void {
    @memcpy(buffer[offset.*..(offset.* + str.len)], str);
    offset.* += str.len;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    var offset: usize = 0;

    for (start_verse..(end_verse + 1)) |verse| {
        if (verse != start_verse) {
            buffer[offset] = '\n';
            offset += 1;
        }

        appendString(buffer, &offset, lyrics[0..this_is_len]);

        appendString(buffer, &offset, lyrics[table[verse]..]);
    }

    return buffer[0..offset];
}
