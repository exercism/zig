// An enum should be helpful for this exercise.

pub const SpaceAge = struct {
    // This struct, as well as its fields and methods, needs to be
    // implemented.

    pub fn init(seconds: isize) SpaceAge {
        _ = seconds;
        @compileError("please implement the init method");
    }

    fn getOrbitalPeriodInSecondsFromEarthYearsOf(planet: Planet) f64 {
        _ = planet;
        @compileError("please implement the getOrbitalPeriodInSecondsFromEarthYearsOf method");
    }

    fn getOrbitalPeriodInEarthYearsOf(planet: Planet) f64 {
        _ = planet;
        @compileError("please implement the getOrbitalPeriodInEarthYearsOf method");
    }

    pub fn onMercury(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onMercury method");
    }

    pub fn onVenus(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onVenus method");
    }

    pub fn onEarth(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onEarth method");
    }

    pub fn onMars(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onMars method");
    }

    pub fn onJupiter(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onJupiter method");
    }

    pub fn onSaturn(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onSaturn method");
    }

    pub fn onUranus(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onUranus method");
    }

    pub fn onNeptune(self: SpaceAge) f64 {
        _ = self;
        @compileError("please implement the onNeptune method");
    }
};
