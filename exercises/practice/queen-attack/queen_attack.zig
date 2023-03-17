pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    pub fn init(row: i8, col: i8) QueenError!Queen {
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
