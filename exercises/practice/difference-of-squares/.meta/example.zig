pub fn squareOfSum(number: isize) isize {
    var result = @divExact(number * (number + 1), 2);
    return result * result;
}

pub fn sumOfSquares(number: isize) isize {
    return @divExact(number * (number + 1) * (2 * number + 1), 6);
}

pub fn differenceOfSquares(number: isize) isize {
    return squareOfSum(number) - sumOfSquares(number);
}
