pub const ComputationError = error{
    IllegalArgument,
};

pub fn steps(start: isize) ComputationError!usize {
    if (start <= 0) {
        return ComputationError.IllegalArgument;
    }
    var number = start;
    var count: usize = 0;
    while (number > 1) {
        if (@mod(number, 2) == 0) {
            number = @divTrunc(number, 2);
        } else {
            number = 3 * number + 1;
        }
        count += 1;
    }
    return count;
}
