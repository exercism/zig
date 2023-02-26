const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub const ClassifyError = error{IllegalArgument};

/// Returns the sum of the divisors of `n` (excluding `n` itself).
/// For example, the aliquot sum of 15 is (1 + 3 + 5) = 9.
fn aliquotSum(n: usize) usize {
    if (n == 1) return 0;
    var result: usize = 1;
    var i: usize = 2;
    const isqrt_n = std.math.sqrt(n);
    while (i <= isqrt_n) : (i += 1) {
        if (n % i == 0) result += i + (n / i);
    }
    // When `n` is a square number, we added the same divisor twice inside the loop.
    if (isqrt_n * isqrt_n == n) result -= isqrt_n;
    return result;
}

pub fn classify(n: usize) ClassifyError!Classification {
    if (n == 0) return ClassifyError.IllegalArgument;
    const aliquot_sum = aliquotSum(n);
    if (aliquot_sum < n) return Classification.deficient;
    if (aliquot_sum > n) return Classification.abundant;
    return Classification.perfect;
}
