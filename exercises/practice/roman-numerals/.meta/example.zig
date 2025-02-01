const std = @import("std");
const mem = std.mem;
const allocPrint = std.fmt.allocPrint;

const DigitValue = struct {
    value: i16,
    digit: []const u8,
};

const max_result_size = 15;

var digitValues = [_]DigitValue{
    .{ .value = 1000, .digit = "M" },
    .{ .value = 900, .digit = "CM" },
    .{ .value = 500, .digit = "D" },
    .{ .value = 400, .digit = "CD" },
    .{ .value = 100, .digit = "C" },
    .{ .value = 90, .digit = "XC" },
    .{ .value = 50, .digit = "L" },
    .{ .value = 40, .digit = "XL" },
    .{ .value = 10, .digit = "X" },
    .{ .value = 9, .digit = "IX" },
    .{ .value = 5, .digit = "V" },
    .{ .value = 4, .digit = "IV" },
    .{ .value = 1, .digit = "I" },
};

pub fn toRoman(allocator: mem.Allocator, arabicNumeral: i16) mem.Allocator.Error![]u8 {
    var tmp: [max_result_size]u8 = undefined;
    var numeral: i16 = arabicNumeral;
    var len: usize = 0;
    for (digitValues) |dv| {
        while (numeral >= dv.value) {
            @memcpy(tmp[len..(len + dv.digit.len)], dv.digit);
            len += dv.digit.len;
            numeral -= dv.value;
        }
    }
    const result = try allocator.alloc(u8, len);
    @memcpy(result, tmp[0..len]);
    return result;
}
