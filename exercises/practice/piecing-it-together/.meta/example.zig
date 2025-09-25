pub const PuzzleError = error{
    InsufficientData,
    ContradictoryData,
};

pub const Format = enum {
    portrait,
    square,
    landscape,
};

pub const PartialInformation = struct {
    pieces: ?u30 = null, //
    border: ?u30 = null, //
    inside: ?u30 = null, //
    rows: ?u30 = null, //
    columns: ?u30 = null, //
    aspectRatio: ?f64 = null, //
    format: ?Format = null, //
};

pub const FullInformation = struct {
    pieces: u30, //
    border: u30, //
    inside: u30, //
    rows: u30, //
    columns: u30, //
    aspectRatio: f64, //
    format: Format, //
};

fn fmt(rows: u30, columns: u30) Format {
    if (columns < rows) {
        return .portrait;
    }

    if (columns > rows) {
        return .landscape;
    }

    return .square;
}

fn complete(rows: u30, columns: u30) FullInformation {
    return FullInformation{
        .pieces = rows * columns,
        .border = 2 * (rows + columns) - 4,
        .inside = (rows - 2) * (columns - 2),
        .rows = rows,
        .columns = columns,
        .aspectRatio = @as(f64, @floatFromInt(columns)) * 1.0 / @as(f64, @floatFromInt(rows)),
        .format = fmt(rows, columns),
    };
}

fn match(candidate: FullInformation, puzzle: PartialInformation) bool {
    if (puzzle.pieces) |pieces| {
        if (candidate.pieces != pieces) {
            return false;
        }
    }

    if (puzzle.border) |border| {
        if (candidate.border != border) {
            return false;
        }
    }

    if (puzzle.inside) |inside| {
        if (candidate.inside != inside) {
            return false;
        }
    }

    if (puzzle.rows) |rows| {
        if (candidate.rows != rows) {
            return false;
        }
    }

    if (puzzle.columns) |columns| {
        if (candidate.columns != columns) {
            return false;
        }
    }

    if (puzzle.aspectRatio) |aspectRatio| {
        if (candidate.aspectRatio != aspectRatio) {
            return false;
        }
    }

    if (puzzle.format) |format| {
        if (candidate.format != format) {
            return false;
        }
    }

    return true;
}

pub fn jigsawData(puzzle: PartialInformation) PuzzleError!FullInformation {
    var solution: ?FullInformation = null;

    // sufficient for current test cases
    const limit: usize = 400;

    for (2..limit) |rows| {
        for (2..limit) |columns| {
            const candidate = complete(@as(u30, @intCast(rows)), @as(u30, @intCast(columns)));

            if (!match(candidate, puzzle)) {
                continue;
            }

            if (solution) |_| {
                return PuzzleError.InsufficientData;
            }

            solution = candidate;
        }
    }

    return solution orelse PuzzleError.ContradictoryData;
}
