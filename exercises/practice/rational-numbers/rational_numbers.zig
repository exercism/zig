pub const Rational = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    pub fn init(numer: i64, denom: i64) RationalError!Rational {
        _ = numer;
        _ = denom;
        @compileError("please implement the init method");
    }

    pub fn equal(self: Rational, other: Rational) bool {
        _ = self;
        _ = other;
        @compileError("please implement the equal method");
    }

    pub fn add(self: Rational, other: Rational) Rational {
        _ = self;
        _ = other;
        @compileError("please implement the add method");
    }

    pub fn sub(self: Rational, other: Rational) Rational {
        _ = self;
        _ = other;
        @compileError("please implement the sub method");
    }

    pub fn mul(self: Rational, other: Rational) Rational {
        _ = self;
        _ = other;
        @compileError("please implement the mul method");
    }

    pub fn div(self: Rational, other: Rational) Rational {
        _ = self;
        _ = other;
        @compileError("please implement the div method");
    }

    pub fn abs(self: Rational) Rational {
        _ = self;
        @compileError("please implement the abs method");
    }

    pub fn pow(self: Rational, n: u32) f64 {
        _ = self;
        _ = n;
        @compileError("please implement the pow method");
    }

    pub fn exp(self: Rational, base: f64) Rational {
        _ = self;
        _ = base;
        @compileError("please implement the exp method");
    }
};
