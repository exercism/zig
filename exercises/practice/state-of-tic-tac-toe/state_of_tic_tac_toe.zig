pub const GameState = enum {
    win,
    draw,
    ongoing,
    impossible,
};

pub fn gameState(board: []const []const u8) GameState {
    _ = board;
    @compileError("please implement the gameState function");
}
