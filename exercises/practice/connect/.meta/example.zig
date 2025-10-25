const std = @import("std");
const math = std.math;
const mem = std.mem;

pub const Cell = struct {
    row: usize,
    column: usize,

    pub fn read(self: *const Cell, board: []const []const u8) u8 {
        return board[self.row][2 * self.column + self.row];
    }
};

pub const CellContext = struct {
    pub fn hash(_: *const CellContext, key: Cell) u64 {
        return (key.row << 16) ^ key.column;
    }

    pub fn eql(_: *const CellContext, first: Cell, second: Cell) bool {
        return first.row == second.row and first.column == second.column;
    }
};

// std.math.maxInt(usize) is equivalent to -1
const edges = [6][2]usize{
    .{ // above, left
        std.math.maxInt(usize),
        0,
    },
    .{ // above, right
        std.math.maxInt(usize),
        1,
    },
    .{ // left
        0,
        std.math.maxInt(usize),
    },
    .{ // right
        0,
        1,
    },
    .{ // below, left
        1,
        std.math.maxInt(usize),
    },
    .{ // below, right
        1,
        0,
    },
};

pub fn winner(allocator: mem.Allocator, board: []const []const u8) mem.Allocator.Error!u8 {
    var pending = std.array_list.Managed(Cell).init(allocator);
    defer pending.deinit();
    var seen = std.hash_map.HashMap(Cell, void, CellContext, 50).init(allocator);
    defer seen.deinit();

    const rows = board.len;
    std.debug.assert(rows > 0);
    const columns = (board[0].len + 1) >> 1;
    std.debug.assert(columns > 0);

    // Each O on bottom side
    for (0..columns) |j| {
        const cell = Cell{ .row = rows - 1, .column = j };
        if (cell.read(board) == 'O') {
            try pending.append(cell);
            try seen.put(cell, {});
        }
    }

    // Each X on right side
    for (0..rows) |i| {
        const cell = Cell{ .row = i, .column = columns - 1 };
        if (cell.read(board) == 'X') {
            try pending.append(cell);
            try seen.put(cell, {});
        }
    }

    while (pending.pop()) |cell| {
        const stone = cell.read(board);

        // Reached O on top side?
        if (stone == 'O' and cell.row == 0) {
            return 'O';
        }

        // Reached X on left side?
        if (stone == 'X' and cell.column == 0) {
            return 'X';
        }

        for (edges) |edge| {
            const adjacent = Cell{ .row = cell.row +% edge[0], .column = cell.column +% edge[1] };
            if (adjacent.row >= rows or adjacent.column >= columns or adjacent.read(board) != stone) {
                continue;
            }

            // Is this a newly reached cell?
            if (!(try seen.getOrPut(adjacent)).found_existing) {
                try pending.append(adjacent);
            }
        }
    }

    return '.';
}
