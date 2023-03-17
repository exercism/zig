const std = @import("std");
const expectApproxEqAbs = std.testing.expectApproxEqAbs;

const space_age = @import("space_age.zig");
const Planet = space_age.Planet;

fn testAge(planet: Planet, seconds: usize, expected_age_in_earth_years: f64) !void {
    const tolerance = 0.01;
    const actual = planet.age(seconds);
    try expectApproxEqAbs(expected_age_in_earth_years, actual, tolerance);
}

test "age on earth" {
    try testAge(Planet.earth, 1_000_000_000, 31.69);
}

test "age on mercury" {
    try testAge(Planet.mercury, 2_134_835_688, 280.88);
}

test "age on venus" {
    try testAge(Planet.venus, 189_839_836, 9.78);
}

test "age on mars" {
    try testAge(Planet.mars, 2_129_871_239, 35.88);
}

test "age on jupiter" {
    try testAge(Planet.jupiter, 901_876_382, 2.41);
}

test "age on saturn" {
    try testAge(Planet.saturn, 2_000_000_000, 2.15);
}

test "age on uranus" {
    try testAge(Planet.uranus, 1_210_123_456, 0.46);
}

test "age on neptune" {
    try testAge(Planet.neptune, 1_821_023_456, 0.35);
}
