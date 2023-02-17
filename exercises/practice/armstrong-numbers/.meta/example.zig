const std = @import("std");
const math = std.math;

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) return true;
    const num_digits = 1 + @floatToInt(u128, @trunc(@log10(@intToFloat(f64, num))));
    var n = num;
    var sum: u128 = 0;
    while (n > 0) {
        sum +|= math.pow(u128, n % 10, num_digits);
        n /= 10;
    }
    return sum == num;
}
