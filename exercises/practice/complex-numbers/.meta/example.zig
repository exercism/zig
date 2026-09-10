const std = @import("std");
const math = std.math;

/// Returns a complex number type whose real and imaginary parts are of the
/// float type `T`.
pub fn Complex(comptime T: type) type {
    return struct {
        const Self = @This();

        real: T,
        imag: T,

        /// Initializes a complex number with the given real and imaginary parts.
        pub fn init(real: T, imag: T) Self {
            return .{
                .real = real,
                .imag = imag,
            };
        }

        /// Returns the sum of two complex numbers.
        pub fn add(self: Self, other: Self) Self {
            return .{
                .real = self.real + other.real,
                .imag = self.imag + other.imag,
            };
        }

        /// Returns the difference of two complex numbers.
        pub fn sub(self: Self, other: Self) Self {
            return .{
                .real = self.real - other.real,
                .imag = self.imag - other.imag,
            };
        }

        /// Returns the product of two complex numbers.
        pub fn mul(self: Self, other: Self) Self {
            return .{
                .real = self.real * other.real - self.imag * other.imag,
                .imag = self.imag * other.real + self.real * other.imag,
            };
        }

        /// Returns the quotient of two complex numbers.
        pub fn div(self: Self, other: Self) Self {
            const denominator = other.real * other.real + other.imag * other.imag;
            return .{
                .real = (self.real * other.real + self.imag * other.imag) / denominator,
                .imag = (self.imag * other.real - self.real * other.imag) / denominator,
            };
        }

        /// Returns the complex conjugate.
        pub fn conjugate(self: Self) Self {
            return .{
                .real = self.real,
                .imag = -self.imag,
            };
        }

        /// Returns the absolute value (modulus).
        pub fn abs(self: Self) T {
            return math.hypot(self.real, self.imag);
        }

        /// Returns the complex exponential function of the number.
        pub fn exp(self: Self) Self {
            const magnitude = @exp(self.real);
            return .{
                .real = magnitude * @cos(self.imag),
                .imag = magnitude * @sin(self.imag),
            };
        }
    };
}
