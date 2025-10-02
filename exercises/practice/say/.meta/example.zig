const std = @import("std");
const mem = std.mem;

pub const SayError = error{
    OutOfRange,
};

pub fn say(allocator: mem.Allocator, number: i41) (mem.Allocator.Error || SayError)![]u8 {
    if (number < 0 or number > 999_999_999_999) {
        return SayError.OutOfRange;
    }

    // sufficient space for 777_777_777_777 in words, plus trailing space.
    var list = try std.array_list.Managed(u8).initCapacity(allocator, 137);
    errdefer list.deinit();

    var n = @as(u64, @intCast(number));

    const billions = n / 1_000_000_000;
    n %= 1_000_000_000;

    const millions = n / 1_000_000;
    n %= 1_000_000;

    const thousands = n / 1_000;
    n %= 1_000;

    say3(&list, billions, "billion ");
    say3(&list, millions, "million ");
    say3(&list, thousands, "thousand ");
    say3(&list, n, "");

    if (list.pop() == null) {
        list.appendSliceAssumeCapacity("zero");
    }

    return list.toOwnedSlice();
}

const names = [_][]const u8{
    "zero ",
    "one ",
    "two ",
    "three ",
    "four ",
    "five ",
    "six ",
    "seven ",
    "eight ",
    "nine ",
    "ten ",
    "eleven ",
    "twelve ",
    "thirteen ",
    "fourteen ",
    "fifteen ",
    "sixteen ",
    "seventeen ",
    "eighteen ",
    "nineteen ",
};

const decade_names = [_][]const u8{
    "zero ",
    "ten ",
    "twenty ",
    "thirty ",
    "forty ",
    "fifty ",
    "sixty ",
    "seventy ",
    "eighty ",
    "ninety ",
};

fn say3(list: *std.array_list.Managed(u8), number: u64, units: []const u8) void {
    if (number == 0) {
        return;
    }

    var n = number;
    const hundreds = n / 100;
    n %= 100;
    if (hundreds != 0) {
        list.appendSliceAssumeCapacity(names[hundreds]);
        list.appendSliceAssumeCapacity("hundred ");
    }

    if (n >= 20) {
        const tens = n / 10;
        n %= 10;
        list.appendSliceAssumeCapacity(decade_names[tens]);
        if (n != 0) {
            _ = list.pop();
            list.appendAssumeCapacity('-');
        }
    }

    if (n != 0) {
        list.appendSliceAssumeCapacity(names[n]);
    }

    list.appendSliceAssumeCapacity(units);
}
