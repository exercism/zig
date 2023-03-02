pub const TriangleError = error{
    Degenerate,
    InvalidInequality,
};

pub const Triangle = struct {
    first: f64,
    second: f64,
    third: f64,

    pub fn init(first: f64, second: f64, third: f64) TriangleError!Triangle {
        try verifyIfDegenerateAttributesExist(first, second, third);
        try verifyIfTriangleInequalityHolds(first, second, third);
        return Triangle{
            .first = first,
            .second = second,
            .third = third,
        };
    }

    fn verifyIfDegenerateAttributesExist(first: f64, second: f64, third: f64) TriangleError!void {
        if ((first + second == third) or
            (first + third == second) or
            (second + third == first))
        {
            return TriangleError.Degenerate;
        }
    }

    fn verifyIfTriangleInequalityHolds(first: f64, second: f64, third: f64) TriangleError!void {
        if ((first + second < third) or
            (first + third < second) or
            (second + third < first))
        {
            return TriangleError.InvalidInequality;
        }
    }

    pub fn isEquilateral(self: Triangle) bool {
        return (self.first == self.second) and
            (self.second == self.third) and
            (self.first == self.third);
    }

    pub fn isIsosceles(self: Triangle) bool {
        return (self.first == self.second) or
            (self.second == self.third) or
            (self.first == self.third);
    }

    pub fn isScalene(self: Triangle) bool {
        return (self.first != self.second) and
            (self.second != self.third) and
            (self.first != self.third);
    }
};
