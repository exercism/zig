pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const x: f64 = switch (self) {
            .mercury => 0.2408467,
            .venus => 0.61419726,
            .earth => 1.0,
            .mars => 1.8808158,
            .jupiter => 11.862615,
            .saturn => 29.447498,
            .uranus => 84.016846,
            .neptune => 164.79132,
        };
        const earth_year_in_seconds = 31_557_600;
        return @intToFloat(f64, seconds) / (earth_year_in_seconds * x);
    }
};
