const std = @import("std");
const expect = std.testing.expect;
const approxEqRel = std.math.approxEqRel;

const space_age = @import("space_age.zig");

test "age on earth" {
    const sp = comptime space_age.SpaceAge.init(1000000000);
    const expected = 31.69;
    const actual = comptime sp.onEarth();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on mercury" {
    const sp = comptime space_age.SpaceAge.init(2134835688);
    const expected = 280.88;
    const actual = comptime sp.onMercury();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on venus" {
    const sp = comptime space_age.SpaceAge.init(189839836);
    const expected = 9.78;
    const actual = comptime sp.onVenus();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on mars" {
    const sp = comptime space_age.SpaceAge.init(2129871239);
    const expected = 35.88;
    const actual = comptime sp.onMars();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on jupiter" {
    const sp = comptime space_age.SpaceAge.init(901876382);
    const expected = 2.41;
    const actual = comptime sp.onJupiter();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on saturn" {
    const sp = comptime space_age.SpaceAge.init(2000000000);
    const expected = 2.15;
    const actual = comptime sp.onSaturn();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on uranus" {
    const sp = comptime space_age.SpaceAge.init(1210123456);
    const expected = 0.46;
    const actual = comptime sp.onUranus();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}

test "age on neptune" {
    const sp = comptime space_age.SpaceAge.init(1821023456);
    const expected = 0.35;
    const actual = comptime sp.onNeptune();
    comptime try expect(approxEqRel(f64, expected, actual, 1.0));
}
