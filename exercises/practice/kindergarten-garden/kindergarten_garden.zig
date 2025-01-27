pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    _ = diagram;
    _ = student;
    @compileError("please implement the plants function");
}
