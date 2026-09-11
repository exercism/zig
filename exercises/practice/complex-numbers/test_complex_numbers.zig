const std = @import("std");
const testing = std.testing;

const complex_numbers = @import("complex_numbers.zig");
const Complex = complex_numbers.Complex(f64);

const tolerance = 1e-12;

fn expectEqualComplex(expected: Complex, actual: Complex) !void {
    try testing.expectApproxEqAbs(expected.real, actual.real, tolerance);
    try testing.expectApproxEqAbs(expected.imag, actual.imag, tolerance);
}

test "Real part-Real part of a purely real number" {
    const z = Complex.init(1, 0);
    try testing.expectEqual(1, z.real);
}

test "Real part-Real part of a purely imaginary number" {
    const z = Complex.init(0, 1);
    try testing.expectEqual(0, z.real);
}

test "Real part-Real part of a number with real and imaginary part" {
    const z = Complex.init(1, 2);
    try testing.expectEqual(1, z.real);
}

test "Imaginary part-Imaginary part of a purely real number" {
    const z = Complex.init(1, 0);
    try testing.expectEqual(0, z.imag);
}

test "Imaginary part-Imaginary part of a purely imaginary number" {
    const z = Complex.init(0, 1);
    try testing.expectEqual(1, z.imag);
}

test "Imaginary part-Imaginary part of a number with real and imaginary part" {
    const z = Complex.init(1, 2);
    try testing.expectEqual(2, z.imag);
}

test "Imaginary unit" {
    const z1 = Complex.init(0, 1);
    const z2 = Complex.init(0, 1);
    try expectEqualComplex(Complex.init(-1, 0), z1.mul(z2));
}

test "Arithmetic-Addition-Add purely real numbers" {
    const z1 = Complex.init(1, 0);
    const z2 = Complex.init(2, 0);
    try expectEqualComplex(Complex.init(3, 0), z1.add(z2));
}

test "Arithmetic-Addition-Add purely imaginary numbers" {
    const z1 = Complex.init(0, 1);
    const z2 = Complex.init(0, 2);
    try expectEqualComplex(Complex.init(0, 3), z1.add(z2));
}

test "Arithmetic-Addition-Add numbers with real and imaginary part" {
    const z1 = Complex.init(1, 2);
    const z2 = Complex.init(3, 4);
    try expectEqualComplex(Complex.init(4, 6), z1.add(z2));
}

test "Arithmetic-Subtraction-Subtract purely real numbers" {
    const z1 = Complex.init(1, 0);
    const z2 = Complex.init(2, 0);
    try expectEqualComplex(Complex.init(-1, 0), z1.sub(z2));
}

test "Arithmetic-Subtraction-Subtract purely imaginary numbers" {
    const z1 = Complex.init(0, 1);
    const z2 = Complex.init(0, 2);
    try expectEqualComplex(Complex.init(0, -1), z1.sub(z2));
}

test "Arithmetic-Subtraction-Subtract numbers with real and imaginary part" {
    const z1 = Complex.init(1, 2);
    const z2 = Complex.init(3, 4);
    try expectEqualComplex(Complex.init(-2, -2), z1.sub(z2));
}

test "Arithmetic-Multiplication-Multiply purely real numbers" {
    const z1 = Complex.init(1, 0);
    const z2 = Complex.init(2, 0);
    try expectEqualComplex(Complex.init(2, 0), z1.mul(z2));
}

test "Arithmetic-Multiplication-Multiply purely imaginary numbers" {
    const z1 = Complex.init(0, 1);
    const z2 = Complex.init(0, 2);
    try expectEqualComplex(Complex.init(-2, 0), z1.mul(z2));
}

test "Arithmetic-Multiplication-Multiply numbers with real and imaginary part" {
    const z1 = Complex.init(1, 2);
    const z2 = Complex.init(3, 4);
    try expectEqualComplex(Complex.init(-5, 10), z1.mul(z2));
}

test "Arithmetic-Division-Divide purely real numbers" {
    const z1 = Complex.init(1, 0);
    const z2 = Complex.init(2, 0);
    try expectEqualComplex(Complex.init(0.5, 0), z1.div(z2));
}

test "Arithmetic-Division-Divide purely imaginary numbers" {
    const z1 = Complex.init(0, 1);
    const z2 = Complex.init(0, 2);
    try expectEqualComplex(Complex.init(0.5, 0), z1.div(z2));
}

test "Arithmetic-Division-Divide numbers with real and imaginary part" {
    const z1 = Complex.init(1, 2);
    const z2 = Complex.init(3, 4);
    try expectEqualComplex(Complex.init(0.44, 0.08), z1.div(z2));
}

test "Absolute value-Absolute value of a positive purely real number" {
    const z = Complex.init(5, 0);
    try testing.expectApproxEqAbs(5, z.abs(), tolerance);
}

test "Absolute value-Absolute value of a negative purely real number" {
    const z = Complex.init(-5, 0);
    try testing.expectApproxEqAbs(5, z.abs(), tolerance);
}

test "Absolute value-Absolute value of a purely imaginary number with positive imaginary part" {
    const z = Complex.init(0, 5);
    try testing.expectApproxEqAbs(5, z.abs(), tolerance);
}

test "Absolute value-Absolute value of a purely imaginary number with negative imaginary part" {
    const z = Complex.init(0, -5);
    try testing.expectApproxEqAbs(5, z.abs(), tolerance);
}

test "Absolute value-Absolute value of a number with real and imaginary part" {
    const z = Complex.init(3, 4);
    try testing.expectApproxEqAbs(5, z.abs(), tolerance);
}

test "Complex conjugate-Conjugate a purely real number" {
    const z = Complex.init(5, 0);
    try expectEqualComplex(Complex.init(5, 0), z.conjugate());
}

test "Complex conjugate-Conjugate a purely imaginary number" {
    const z = Complex.init(0, 5);
    try expectEqualComplex(Complex.init(0, -5), z.conjugate());
}

test "Complex conjugate-Conjugate a number with real and imaginary part" {
    const z = Complex.init(1, 1);
    try expectEqualComplex(Complex.init(1, -1), z.conjugate());
}

test "Complex exponential function-Euler's identity/formula" {
    const z = Complex.init(0, std.math.pi);
    try expectEqualComplex(Complex.init(-1, 0), z.exp());
}

test "Complex exponential function-Exponential of 0" {
    const z = Complex.init(0, 0);
    try expectEqualComplex(Complex.init(1, 0), z.exp());
}

test "Complex exponential function-Exponential of a purely real number" {
    const z = Complex.init(1, 0);
    try expectEqualComplex(Complex.init(std.math.e, 0), z.exp());
}

test "Complex exponential function-Exponential of a number with real and imaginary part" {
    const z = Complex.init(@log(2.0), std.math.pi);
    try expectEqualComplex(Complex.init(-2, 0), z.exp());
}

test "Complex exponential function-Exponential resulting in a number with real and imaginary part" {
    const z = Complex.init(@log(2.0) / 2.0, std.math.pi / 4.0);
    try expectEqualComplex(Complex.init(1, 1), z.exp());
}

test "Operations between real numbers and complex numbers-Add real number to complex number" {
    const z1 = Complex.init(1, 2);
    const z2 = Complex.init(5, 0);
    try expectEqualComplex(Complex.init(6, 2), z1.add(z2));
}

test "Operations between real numbers and complex numbers-Add complex number to real number" {
    const z1 = Complex.init(5, 0);
    const z2 = Complex.init(1, 2);
    try expectEqualComplex(Complex.init(6, 2), z1.add(z2));
}

test "Operations between real numbers and complex numbers-Subtract real number from complex number" {
    const z1 = Complex.init(5, 7);
    const z2 = Complex.init(4, 0);
    try expectEqualComplex(Complex.init(1, 7), z1.sub(z2));
}

test "Operations between real numbers and complex numbers-Subtract complex number from real number" {
    const z1 = Complex.init(4, 0);
    const z2 = Complex.init(5, 7);
    try expectEqualComplex(Complex.init(-1, -7), z1.sub(z2));
}

test "Operations between real numbers and complex numbers-Multiply complex number by real number" {
    const z1 = Complex.init(2, 5);
    const z2 = Complex.init(5, 0);
    try expectEqualComplex(Complex.init(10, 25), z1.mul(z2));
}

test "Operations between real numbers and complex numbers-Multiply real number by complex number" {
    const z1 = Complex.init(5, 0);
    const z2 = Complex.init(2, 5);
    try expectEqualComplex(Complex.init(10, 25), z1.mul(z2));
}

test "Operations between real numbers and complex numbers-Divide complex number by real number" {
    const z1 = Complex.init(10, 100);
    const z2 = Complex.init(10, 0);
    try expectEqualComplex(Complex.init(1, 10), z1.div(z2));
}

test "Operations between real numbers and complex numbers-Divide real number by complex number" {
    const z1 = Complex.init(5, 0);
    const z2 = Complex.init(1, 1);
    try expectEqualComplex(Complex.init(2.5, -2.5), z1.div(z2));
}
