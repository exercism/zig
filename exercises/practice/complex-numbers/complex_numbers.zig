const std = @import("std");

/// Returns a complex number type whose real and imaginary parts are of the
/// float type `T`.
pub fn Complex(comptime T: type) type {
    return struct {
        const Self = @This();

        real: T,
        imag: T,

        /// Initializes a complex number with the given real and imaginary parts.
        pub fn init(real: T, imag: T) Self {
            _ = real;
            _ = imag;
            @compileError("please implement the init function");
        }

        /// Returns the sum of two complex numbers.
        pub fn add(self: Self, other: Self) Self {
            _ = self;
            _ = other;
            @compileError("please implement the add function");
        }

        /// Returns the difference of two complex numbers.
        pub fn sub(self: Self, other: Self) Self {
            _ = self;
            _ = other;
            @compileError("please implement the sub function");
        }

        /// Returns the product of two complex numbers.
        pub fn mul(self: Self, other: Self) Self {
            _ = self;
            _ = other;
            @compileError("please implement the mul function");
        }

        /// Returns the quotient of two complex numbers.
        pub fn div(self: Self, other: Self) Self {
            _ = self;
            _ = other;
            @compileError("please implement the div function");
        }

        /// Returns the complex conjugate.
        pub fn conjugate(self: Self) Self {
            _ = self;
            @compileError("please implement the conjugate function");
        }

        /// Returns the absolute value (modulus).
        pub fn abs(self: Self) T {
            _ = self;
            @compileError("please implement the abs function");
        }

        /// Returns the complex exponential function of the number.
        pub fn exp(self: Self) Self {
            _ = self;
            @compileError("please implement the exp function");
        }
    };
}
