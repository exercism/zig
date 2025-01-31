const std = @import("std");

const green_bottle = " green bottle";

const hanging_on = " hanging on the wall";

const and_if = "And if one green bottle should accidentally fall,\nThere'll be ";

const comma = ",\n";

const stop = ".";

const numbers = [_][]const u8{ "No", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten" };

fn appendString(buffer: []u8, offset: *usize, str: []const u8) void {
    @memcpy(buffer[offset.*..(offset.* + str.len)], str);
    offset.* += str.len;
}

fn appendLine(buffer: []u8, offset: *usize, num_bottles: u32) void {
    appendString(buffer, offset, numbers[num_bottles]);

    appendString(buffer, offset, green_bottle);

    if (num_bottles != 1) {
        buffer[offset.*] = 's';
        offset.* += 1;
    }

    appendString(buffer, offset, hanging_on);
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    var offset: usize = 0;

    var num_bottles = start_bottles;
    while (num_bottles > start_bottles - take_down) {
        if (num_bottles != start_bottles) {
            buffer[offset] = '\n';
            buffer[offset + 1] = '\n';
            offset += 2;
        }

        appendLine(buffer, &offset, num_bottles);
        appendString(buffer, &offset, comma);

        appendLine(buffer, &offset, num_bottles);
        appendString(buffer, &offset, comma);

        appendString(buffer, &offset, and_if);
        num_bottles -= 1;

        const savedOffset = offset;
        appendLine(buffer, &offset, num_bottles);
        buffer[savedOffset] = buffer[savedOffset] | 32;
        appendString(buffer, &offset, stop);
    }

    return buffer[0..offset];
}
