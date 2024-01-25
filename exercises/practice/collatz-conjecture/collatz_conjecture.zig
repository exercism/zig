// Please implement the `ComputationError.IllegalArgument` error.

pub fn steps(number: usize) anyerror!usize {
    _ = number;
    @compileError("please implement the steps function");
}
