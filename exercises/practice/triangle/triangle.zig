pub const Triangle = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        _ = a;
        _ = b;
        _ = c;
        @compileError("please implement the init method");
    }

    pub fn isEquilateral(self: Triangle) bool {
        _ = self;
        @compileError("please implement the isEquilateral method");
    }

    pub fn isIsosceles(self: Triangle) bool {
        _ = self;
        @compileError("please implement the isIsosceles method");
    }

    pub fn isScalene(self: Triangle) bool {
        _ = self;
        @compileError("please implement the isScalene method");
    }
};
