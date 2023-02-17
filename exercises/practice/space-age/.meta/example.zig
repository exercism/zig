pub const Planet = enum(u4) {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,
};

pub const SpaceAge = struct {
    seconds: f64,

    const earth_year_in_seconds = 31_557_600;

    pub fn init(seconds: isize) SpaceAge {
        return SpaceAge {
            .seconds = @intToFloat(f64, seconds),
        };
    }

    fn getOrbitalPeriodInSecondsFromEarthYearsOf(planet: Planet) f64 {
        return earth_year_in_seconds *
            getOrbitalPeriodInEarthYearsOf(planet);
    }

    fn getOrbitalPeriodInEarthYearsOf(planet: Planet) f64 {
        return switch (planet) {
            .mercury => 0.2408467,
            .venus   => 0.61419726,
            .earth   => 1.0,
            .mars    => 1.8808158,
            .jupiter => 11.862615,
            .saturn  => 29.447498,
            .uranus  => 84.016846,
            .neptune => 164.79132,
        };
    }

    pub fn onMercury(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.mercury);
    }

    pub fn onVenus(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.venus);
    }

    pub fn onEarth(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.earth);
    }

    pub fn onMars(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.mars);
    }

    pub fn onJupiter(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.jupiter);
    }

    pub fn onSaturn(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.saturn);
    }

    pub fn onUranus(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.uranus);
    }

    pub fn onNeptune(self: SpaceAge) f64 {
        return self.seconds /
            getOrbitalPeriodInSecondsFromEarthYearsOf(.neptune);
    }
};
