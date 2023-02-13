const std = @import("std");
const math = std.math;

/// Returns the number of digits in `n`.
/// Uses only integer comparison (no repeated divison, nor log10).
/// Optimized for small numbers (no binary search).
fn countDigits(n: u64) u64 {
    var power_of_ten: u64 = 1;
    var count: u8 = 1;
    const max_digits = 20;
    while (count < max_digits) {
        power_of_ten *= 10;
        if (n < power_of_ten) {
            return count;
        }
        count += 1;
    }
    return max_digits;
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
