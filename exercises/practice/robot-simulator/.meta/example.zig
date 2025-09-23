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

    pub fn move(self: Robot, instructions: []const u8) Robot {
        var x = self.x;
        var y = self.y;
        var direction = self.direction;

        for (instructions) |ch| {
            switch (ch) {
                'R' => {
                    switch (direction) {
                        .north => {
                            direction = .east;
                        },
                        .east => {
                            direction = .south;
                        },
                        .south => {
                            direction = .west;
                        },
                        .west => {
                            direction = .north;
                        },
                    }
                },
                'L' => {
                    switch (direction) {
                        .north => {
                            direction = .west;
                        },
                        .east => {
                            direction = .north;
                        },
                        .south => {
                            direction = .east;
                        },
                        .west => {
                            direction = .south;
                        },
                    }
                },
                'A' => {
                    switch (direction) {
                        .north => {
                            y += 1;
                        },
                        .east => {
                            x += 1;
                        },
                        .south => {
                            y -= 1;
                        },
                        .west => {
                            x -= 1;
                        },
                    }
                },
                else => {},
            }
        }

        return .{
            .x = x,
            .y = y,
            .direction = direction,
        };
    }
};
