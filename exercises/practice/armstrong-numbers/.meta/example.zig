const std = @import("std");
const math = std.math;

pub fn isArmstrongNumber(num: u128) bool {
    if (num == 0) return true;
    const num_digits = 1 + math.log10_int(num);
    var n = num;
    var armstrong_sum: u128 = 0;
    while (n > 0) {
        armstrong_sum +|= math.pow(u128, n % 10, num_digits);
        n /= 10;
    }
    return armstrong_sum == num;
}
