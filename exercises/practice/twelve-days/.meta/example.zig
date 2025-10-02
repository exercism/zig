const std = @import("std");

const on_the = "On the ";

const day_of = " day of Christmas my true love gave to me: ";

const gifts = "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";

const ordinals = [_][]const u8{ "", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth" };

const table = [_]usize{ 0, 235, 213, 194, 174, 157, 137, 113, 90, 69, 48, 26, 0 };

fn appendString(buffer: []u8, offset: *usize, str: []const u8) void {
    @memcpy(buffer[offset.*..(offset.* + str.len)], str);
    offset.* += str.len;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    std.debug.assert(start_verse >= 1);
    std.debug.assert(end_verse >= start_verse);
    std.debug.assert(end_verse <= 12);
    var offset: usize = 0;

    for (start_verse..(end_verse + 1)) |verse| {
        if (verse != start_verse) {
            buffer[offset] = '\n';
            offset += 1;
        }

        appendString(buffer, &offset, on_the);

        appendString(buffer, &offset, ordinals[verse]);

        appendString(buffer, &offset, day_of);

        appendString(buffer, &offset, gifts[table[verse]..]);
    }

    return buffer[0..offset];
}
