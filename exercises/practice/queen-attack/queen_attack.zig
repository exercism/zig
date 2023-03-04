pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    pub fn init(x: i8, y: i8) QueenError!Queen {
        _ = x;
        _ = y;
        @compileError("please implement the init method");
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        _ = self;
        _ = other;
        @compileError("please implement the canAttack method");
    }
};
