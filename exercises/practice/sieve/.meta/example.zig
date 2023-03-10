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

pub fn primes(buffer: []u32, comptime limit: u32) []const u32 {
    comptime assert(limit <= 1000);
    const p = comptime eratosthenes(1000);
    var i: u32 = 2;
    var j: usize = 0;
    while (i <= limit) : (i += 1) {
        if (p[i]) {
            buffer[j] = i;
            j += 1;
        }
    }
    return buffer[0..j];
}
