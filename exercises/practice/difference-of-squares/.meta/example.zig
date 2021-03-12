pub fn square_of_sum(number: isize) isize {
    var result = @divExact(number * (number + 1), 2);
    return result * result;
}

pub fn sum_of_squares(number: isize) isize {
    return @divExact(number * (number + 1) * (2 * number + 1), 6);
}

pub fn difference_of_squares(number: isize) isize {
    return square_of_sum(number) - sum_of_squares(number);
}
