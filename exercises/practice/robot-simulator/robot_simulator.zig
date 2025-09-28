pub const Direction = enum {
    north,
    east,
    south,
    west,
};

pub const Robot = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    pub fn init(x: i32, y: i32, direction: Direction) Robot {
        _ = x;
        _ = y;
        _ = direction;
        @compileError("please implement the init method");
    }

    pub fn move(self: *Robot, instructions: []const u8) void {
        _ = self;
        _ = instructions;
        @compileError("please implement the move method");
    }
};
