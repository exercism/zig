pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

fn isWin(bitset: usize) bool {
    const lines = [_]usize{ 0x007, 0x070, 0x700, 0x111, 0x222, 0x444, 0x124, 0x421 };

    for (lines) |line| {
        if ((bitset & line) == line) {
            return true;
        }
    }

    return false;
}

pub fn gameState(board: []const []const u8) GameState {
    var countX: usize = 0;
    var countO: usize = 0;
    var bitsetX: usize = 0;
    var bitsetO: usize = 0;
    var current: usize = 1;

    for (0..3) |row| {
        for (0..3) |column| {
            if (board[row][column] == 'X') {
                countX += 1;
                bitsetX |= current;
            } else if (board[row][column] == 'O') {
                countO += 1;
                bitsetO |= current;
            }
            current = current << 1;
        }
        current = current << 1;
    }

    if (countO > countX) {
        // Wrong turn order: O started
        return .impossible;
    }

    if (countX > countO + 1) {
        // Wrong turn order: X went twice
        return .impossible;
    }

    const winX = isWin(bitsetX);
    const winO = isWin(bitsetO);

    if (winX or winO) {
        if (winX and winO) {
            // Impossible board: game should have ended after the game was won
            return .impossible;
        }

        return .win;
    }

    if (countX + countO == 9) {
        return .draw;
    }

    return .ongoing;
}
