pub const Coordinate = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        _ = x_coord;
        _ = y_coord;
        @compileError("please implement the init method");
    }
    pub fn score(self: Coordinate) usize {
        _ = self;
        @compileError("please implement the score method");
    }
};
