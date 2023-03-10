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
fn genPrimes(comptime limit: u32) []const u32 {
    @setEvalBranchQuota(limit * 3);
    const bools = comptime eratosthenes(limit);
    // See https://en.wikipedia.org/wiki/Prime-counting_function#Inequalities
    const upper_bound_count = @ceil(1.25506 * @as(f64, limit) / @log(@as(f64, limit)));
    var result: [upper_bound_count]u32 = undefined;
    var j = 0;
    for (bools) |b, i| {
        if (b) {
            result[j] = i;
            j += 1;
        }
    }
    return result[0..j];
}

pub fn primes(buffer: []u32, comptime limit: u32) []const u32 {
    const sieve_limit = 1000;
    comptime assert(limit <= sieve_limit);
    const p = comptime genPrimes(sieve_limit); // The primes up to the sieve limit.
    _ = buffer;
    if (limit >= p[p.len - 1]) return p;
    var i: usize = 0;
    while (p[i] <= limit) : (i += 1) {}
    return p[0..i];
}
