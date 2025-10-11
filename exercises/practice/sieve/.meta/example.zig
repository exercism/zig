const assert = @import("std").debug.assert;

pub fn primes(buffer: []u32, comptime limit: u12) []const u32 {
    var index: usize = 0;
    var composite: [4096]bool = undefined;
    @memset(&composite, false);

    for (2..(@as(usize, @intCast(limit)) + 1)) |p| {
        if (composite[p]) {
            continue;
        }

        buffer[index] = @as(u32, @intCast(p));
        index += 1;

        var multiple = p * p;
        while (multiple <= limit) : (multiple += p) {
            composite[multiple] = true;
        }
    }

    return buffer[0..index];
}
