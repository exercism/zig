pub const Queen = struct {
    pub fn init(row: u3, col: u3) Queen {
        _ = row;
        _ = col;
        @compileError("please implement the init method");
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        _ = self;
        _ = other;
        @compileError("please implement the canAttack method");
    }
};
