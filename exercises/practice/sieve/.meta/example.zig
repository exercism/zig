const assert = @import("std").debug.assert;

/// Returns bools, where `result[i]` is `true` iff `i` is a prime number.
fn eratosthenes(comptime n: u32) []const bool {
    var result = [_]bool{false} ** (n + 1);
    result[2] = true;

    var i = 3;
    while (i <= n) : (i += 2) {
        result[i] = true;
    }

    i = 3;
    const sqrt_n = @floatToInt(u32, @sqrt(@as(f64, n))); // Optimization: stop at sqrt(n)
    while (i <= sqrt_n) : (i += 2) {
        if (result[i]) {
            var j = i * i; // Optimization: start at i*i
            while (j < n) : (j += 2 * i) {
                result[j] = false;
            }
        }
    }
    return &result;
}

/// Returns the prime numbers up to `limit`.
fn genPrimes(comptime limit: u32, comptime count: u32) []const u32 {
    const bools = comptime eratosthenes(limit);
    var result: [count]u32 = undefined;
    var j = 0;
    @setEvalBranchQuota(2000);
    for (bools) |b, i| {
        if (b) {
            result[j] = i;
            j += 1;
        }
    }
    return &result;
}

pub fn primes(buffer: []u32, comptime limit: u32) []const u32 {
    comptime assert(limit <= 1000);
    const primes_under_1000 = comptime genPrimes(1000, 168);
    _ = buffer;
    if (limit >= primes_under_1000[primes_under_1000.len - 1]) return primes_under_1000;
    var i: usize = 0;
    while (primes_under_1000[i] <= limit) : (i += 1) {}
    return primes_under_1000[0..i];
}
