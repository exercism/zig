const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Returns the sum of the divisors of `n` (excluding `n` itself).
/// For example, the aliquot sum of 15 is (1 + 3 + 5) = 9.
fn aliquotSum(n: u64) u64 {
    if (n == 1) return 0;
    var result: u64 = 1;
    const isqrt_n = std.math.sqrt(n);
    for (2..isqrt_n + 1) |i| {
        if (n % i == 0) result += i + (n / i);
    }
    // When `n` is a square number, we added the same divisor twice inside the loop.
    if (isqrt_n * isqrt_n == n) result -= isqrt_n;
    return result;
}

/// Returns whether `n` is less than, equal to, or greater than its aliquot sum.
/// Asserts that `n` is nonzero.
pub fn classify(comptime n: u64) Classification {
    comptime std.debug.assert(n != 0);
    const aliquot_sum = aliquotSum(n);
    if (aliquot_sum < n) return Classification.deficient;
    if (aliquot_sum > n) return Classification.abundant;
    return Classification.perfect;
}
