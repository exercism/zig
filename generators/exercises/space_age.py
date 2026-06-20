from lib import zint, zfloat

IMPORT_SELF = False
HEADER = (
    "const expectApproxEqAbs = std.testing.expectApproxEqAbs;\n\n"
    'const space_age = @import("space_age.zig");\n'
    "const Planet = space_age.Planet;\n\n"
    "fn testAge(planet: Planet, seconds: usize, expected_age_in_earth_years: f64) !void {\n"
    "    const tolerance = 0.01;\n"
    "    const actual = planet.age(seconds);\n"
    "    try expectApproxEqAbs(expected_age_in_earth_years, actual, tolerance);\n"
    "}\n"
)


def describe(case, parent):
    # The committed target lowercases the planet name in each test title.
    return case["description"].lower()


def gen_case(case):
    planet = case["input"]["planet"].lower()
    seconds = zint(case["input"]["seconds"])
    expected = zfloat(case["expected"])
    return f"    try testAge(Planet.{planet}, {seconds}, {expected});\n"
