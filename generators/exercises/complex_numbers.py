IMPORT_SELF = True

HEADER = """const Complex = complex_numbers.Complex(f64);

const tolerance = 1e-12;

fn expectEqualComplex(expected: Complex, actual: Complex) !void {
    try testing.expectApproxEqAbs(expected.real, actual.real, tolerance);
    try testing.expectApproxEqAbs(expected.imag, actual.imag, tolerance);
}
"""

# Symbolic values appearing in the canonical data.
EXPRESSIONS = {
    "pi": "std.math.pi",
    "e": "std.math.e",
    "ln(2)": "@log(2.0)",
    "ln(2)/2": "@log(2.0) / 2.0",
    "pi/4": "std.math.pi / 4.0",
}


def scalar(v):
    return EXPRESSIONS[v] if isinstance(v, str) else repr(v)


def complex_(v):
    # A bare number stands for a complex number with imaginary part 0.
    if not isinstance(v, list):
        v = [v, 0]
    return f"Complex.init({scalar(v[0])}, {scalar(v[1])})"


def gen_case(case):
    prop = case["property"]
    inp = case["input"]
    e = case["expected"]

    if prop in ("real", "imaginary"):
        field = "real" if prop == "real" else "imag"
        return (
            f"    const z = {complex_(inp['z'])};\n"
            f"    try testing.expectEqual({scalar(e)}, z.{field});\n"
        )

    if prop == "abs":
        return (
            f"    const z = {complex_(inp['z'])};\n"
            f"    try testing.expectApproxEqAbs({scalar(e)}, z.abs(), tolerance);\n"
        )

    if prop in ("conjugate", "exp"):
        return (
            f"    const z = {complex_(inp['z'])};\n"
            f"    try expectEqualComplex({complex_(e)}, z.{prop}());\n"
        )

    # Binary operations: add, sub, mul, div.
    return (
        f"    const z1 = {complex_(inp['z1'])};\n"
        f"    const z2 = {complex_(inp['z2'])};\n"
        f"    try expectEqualComplex({complex_(e)}, z1.{prop}(z2));\n"
    )
