const std = @import("std");
const math = std.math;

/// Returns the number of digits in `n`.
fn countDigits(n: u64) u64 {
    if (n == 0) return 1;
    return 1 + @floatToInt(u64, @trunc(@log10(@intToFloat(f64, n))));
}

pub fn isArmstrongNumber(num: u64) bool {
    const num_digits = countDigits(num);
    var n = num;
    var sum: u64 = 0;
    while (n > 0) {
        sum +|= math.pow(u64, n % 10, num_digits);
        n /= 10;
    }
    return sum == num;
}
