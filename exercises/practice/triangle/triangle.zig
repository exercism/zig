pub const Triangle = struct {
    // This struct, as well as it's fields and methods, needs to be implemented.

    pub fn init(
        first: f64,
        second: f64,
        third: f64
    ) TriangleError!Triangle {
        @panic("please implement the init method");
    }

    fn verifyIfDegenerateAttributesExist(
        first: f64,
        second: f64,
        third: f64
    ) TriangleError!void {
        @panic("optional verifyIfDegenerateAttributesExist method");
    }

    fn verifyIfTriangleInequalityHolds(
        first: f64,
        second: f64,
        third: f64
    ) TriangleError!void {
        @panic("please implement the verifyIfTriangleInequalityHolds method");
    }

    pub fn isEquilateral(self: Triangle) bool {
        @panic("please implement the isEquilateral method");
    }

    pub fn isIsosceles(self: Triangle) bool {
        @panic("please implement the isIsosceles method");
    }

    pub fn isScalene(self: Triangle) bool {
        @panic("please implement the isScalene method");
    }
};
