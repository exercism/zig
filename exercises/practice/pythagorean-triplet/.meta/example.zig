const std = @import("std");
const mem = std.mem;

pub const Triplet = struct {
    a: usize,
    b: usize,
    c: usize,

    pub fn init(a: usize, b: usize, c: usize) Triplet {
        return .{ .a = a, .b = b, .c = c };
    }
};

// For every Pythagorean triplet with total a + b + c = n,
// a² + b² = c²
// <=> a² + b² = (n - a - b)², substituting c
// <=> 0 = n² - 2*n*a - 2*n*b + 2*a*b
// <=> (2*n - 2*a) b = (n² - 2*n*a)
// <=> b = (n² - 2*n*a) / (2*n - 2*a)
//
// The denominator is never 0, as perimeter exceeds a side length.
//
pub fn tripletsWithSum(allocator: mem.Allocator, n: usize) mem.Allocator.Error![]Triplet {
    var buffer = try allocator.alloc(Triplet, n / 3);
    if (buffer.len == 0) {
        return buffer;
    }

    defer allocator.free(buffer);

    var a: usize = 1;
    var numTriples: usize = 0;
    while (true) {
        const numerator = n * (n - 2 * a);
        const denominator = 2 * (n - a);
        const b = numerator / denominator;
        if (b <= a) {
            break;
        }
        if (numerator % denominator == 0) {
            buffer[numTriples] = Triplet.init(a, b, n - a - b);
            numTriples += 1;
        }

        a += 1;
    }

    const result = try allocator.alloc(Triplet, numTriples);
    @memcpy(result, buffer[0..numTriples]);
    return result;
}
