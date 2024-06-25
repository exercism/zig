pub fn eggCount(number: usize) usize {
    var result: usize = 0;
    var n = number;
    while (n > 0) {
        n -= n & (0 -% n);
        result += 1;
    }
    return result;
}
