const std = @import("std");
const math = std.math;

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) return true;
    // Currently, the below can produce an incorrect count for numbers near a large power of ten.
    // For example, it produces 16 for the 15-digit 999_999_999_999_998.
    const num_digits = 1 + math.log10(num);
    var n = num;
    var armstrong_sum: u128 = 0;
    while (n > 0) {
        armstrong_sum +|= math.pow(u128, n % 10, num_digits);
        n /= 10;
    }
    return armstrong_sum == num;
}
