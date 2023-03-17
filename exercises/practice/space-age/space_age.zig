pub const Planet = enum {
    mercury,

    pub fn age(self: Planet, seconds: usize) f64 {
        _ = self;
        _ = seconds;
        @compileError("please implement the age method");
    }
};
