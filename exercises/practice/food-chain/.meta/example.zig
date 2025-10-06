const std = @import("std");

const i_know = "I know an old lady who swallowed a ";

const stop = ".\n";

const she_swallowed = "She swallowed the ";

const to_catch = " to catch the ";

const that_wriggled = " that wriggled and jiggled and tickled inside her";

const animals = [_][]const u8{ "", "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" };

const exclamations = [_][]const u8{
    "", //
    "I don't know why she swallowed the fly. Perhaps she'll die.", //
    "It wriggled and jiggled and tickled inside her.\n", //
    "How absurd to swallow a bird!\n", //
    "Imagine that, to swallow a cat!\n", //
    "What a hog, to swallow a dog!\n", //
    "Just opened her throat and swallowed a goat!\n", //
    "I don't know how she swallowed a cow!\n", //
    "She's dead, of course!", //
};

fn appendString(buffer: []u8, offset: *usize, str: []const u8) void {
    @memcpy(buffer[offset.*..(offset.* + str.len)], str);
    offset.* += str.len;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    std.debug.assert(start_verse >= 1);
    std.debug.assert(end_verse >= start_verse);
    std.debug.assert(end_verse <= 8);
    var offset: usize = 0;

    for (start_verse..(end_verse + 1)) |verse| {
        if (verse != start_verse) {
            buffer[offset] = '\n';
            buffer[offset + 1] = '\n';
            offset += 2;
        }

        appendString(buffer, &offset, i_know);

        appendString(buffer, &offset, animals[verse]);

        appendString(buffer, &offset, stop);

        appendString(buffer, &offset, exclamations[verse]);

        if (verse == 1 or verse == 8) {
            continue;
        }

        var animal = verse;
        while (animal > 1) {
            appendString(buffer, &offset, she_swallowed);

            appendString(buffer, &offset, animals[animal]);

            appendString(buffer, &offset, to_catch);

            animal -= 1;
            appendString(buffer, &offset, animals[animal]);

            if (animal == 2) {
                appendString(buffer, &offset, that_wriggled);
            }

            appendString(buffer, &offset, stop);
        }

        appendString(buffer, &offset, exclamations[1]);
    }

    return buffer[0..offset];
}
