pub fn squareRoot(radicand: usize) usize {
    var result: usize = 0;
    while (result * result < radicand) {
        result += 1;
    }
    return result;
}
