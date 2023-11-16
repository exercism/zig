pub const ComputationError = error{ IllegalArgument };

pub fn steps(number: usize) anyerror!usize {
    _ = number;
    @compileError("please implement the steps function or return aforementioned error");
}
