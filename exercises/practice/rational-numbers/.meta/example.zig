const std = @import("std");

pub const RationalError = error{
    InitializationFailure,
};

pub const Rational = struct {
    numerator: i64,
    denominator: i64,

    pub fn init(numer: i64, denom: i64) RationalError!Rational {
        if (denom == 0) return RationalError.InitializationFailure;
        const abs_numer = if (numer < 0) -numer else numer;
        const abs_denom = if (denom < 0) -denom else denom;
        const gcd_num = gcd(abs_numer, abs_denom);

        var numerator = @divExact(numer, gcd_num);
        var denominator = @divExact(denom, gcd_num);

        if (denominator < 0) {
            numerator *= -1;
            denominator *= -1;
        }
        return Rational{ .numerator = numerator, .denominator = denominator };
    }
    /// Equals
    pub fn equal(self: Rational, other: Rational) bool {
        return self.numerator == other.numerator and self.denominator == other.denominator;
    }
    /// Addition
    pub fn add(self: Rational, other: Rational) Rational {
        const numer = (self.numerator * other.denominator) + (self.denominator * other.numerator);
        return Rational.init(numer, self.denominator * other.denominator) catch unreachable;
    }
    /// Subtraction
    pub fn sub(self: Rational, other: Rational) Rational {
        const numer = (self.numerator * other.denominator) - (self.denominator * other.numerator);
        return Rational.init(numer, self.denominator * other.denominator) catch unreachable;
    }
    /// Multiplication
    pub fn mul(self: Rational, other: Rational) Rational {
        return Rational.init(self.numerator * other.numerator, self.denominator * other.denominator) catch unreachable;
    }
    /// Division
    pub fn div(self: Rational, other: Rational) Rational {
        return Rational.init(self.numerator * other.denominator, self.denominator * other.numerator) catch unreachable;
    }
    /// Absolute value
    pub fn abs(self: Rational) Rational {
        return Rational.init(std.math.absInt(self.numerator) catch unreachable, std.math.absInt(self.denominator) catch unreachable) catch unreachable;
    }
    /// Exponential value
    pub fn exp(self: Rational, n: i64) Rational {
        return Rational.init(std.math.pow(i64, self.numerator, n), std.math.pow(i64, self.denominator, n)) catch unreachable;
    }
    /// Exponential real value
    pub fn exp_real(self: Rational, base: f64) f64 {
        const exponent = @log10(std.math.pow(f64, base, @intToFloat(f64, self.numerator))) / @intToFloat(f64, self.denominator);
        return std.math.pow(f64, 10, exponent);
    }
};

/// Computes GCD of two integers
pub fn gcd(a: i64, b: i64) i64 {
    var x: i64 = a;
    var y: i64 = b;
    var m: i64 = a;
    while (y != 0) {
        m = @rem(x, y);
        x = y;
        y = m;
    }
    return x;
}
