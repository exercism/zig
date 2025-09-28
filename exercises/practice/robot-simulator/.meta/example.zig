pub const Direction = enum {
    north,
    east,
    south,
    west,
};

pub const Robot = struct {
    x: i32,
    y: i32,
    direction: Direction,

    pub fn init(x: i32, y: i32, direction: Direction) Robot {
        return .{
            .x = x,
            .y = y,
            .direction = direction,
        };
    }

    pub fn move(self: *Robot, instructions: []const u8) void {
        for (instructions) |ch| {
            switch (ch) {
                'R' => {
                    switch (self.direction) {
                        .north => {
                            self.direction = .east;
                        },
                        .east => {
                            self.direction = .south;
                        },
                        .south => {
                            self.direction = .west;
                        },
                        .west => {
                            self.direction = .north;
                        },
                    }
                },
                'L' => {
                    switch (self.direction) {
                        .north => {
                            self.direction = .west;
                        },
                        .east => {
                            self.direction = .north;
                        },
                        .south => {
                            self.direction = .east;
                        },
                        .west => {
                            self.direction = .south;
                        },
                    }
                },
                'A' => {
                    switch (self.direction) {
                        .north => {
                            self.y += 1;
                        },
                        .east => {
                            self.x += 1;
                        },
                        .south => {
                            self.y -= 1;
                        },
                        .west => {
                            self.x -= 1;
                        },
                    }
                },
                else => {},
            }
        }
    }
};
