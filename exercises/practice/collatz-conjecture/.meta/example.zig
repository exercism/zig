pub const ComputationError = error{
    IllegalArgument,
};

pub fn steps(start: usize) ComputationError!usize {
    if (start == 0) {
        return ComputationError.IllegalArgument;
    }
    var n = start;
    var result: usize = 0;
    while (n > 1) {
        n = if (n % 2 == 0) n / 2 else 3 * n + 1;
        result += 1;
    }
    return result;
}
