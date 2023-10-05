pub const TriangleError = error{
    Invalid,
};

pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        if ((a + b <= c) or (a + c <= b) or (b + c <= a)) return TriangleError.Invalid;
        return .{ .a = a, .b = b, .c = c };
    }

    pub fn isEquilateral(self: Triangle) bool {
        return (self.a == self.b) and (self.b == self.c) and (self.a == self.c);
    }

    pub fn isIsosceles(self: Triangle) bool {
        return (self.a == self.b) or (self.b == self.c) or (self.a == self.c);
    }

    pub fn isScalene(self: Triangle) bool {
        return (self.a != self.b) and (self.b != self.c) and (self.a != self.c);
    }
};
