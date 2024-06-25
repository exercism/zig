pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    for (digits) |ch| {
        const units: u8 = ch -% '0';
        if (units > 9) {
            return SeriesError.InvalidCharacter;
        }
    }

    if (span < 0) {
        return SeriesError.NegativeSpan;
    }

    if (span == 0) {
        return 1;
    }

    const size: u64 = @intCast(span);

    if (digits.len < size) {
        return SeriesError.InsufficientDigits;
    }

    var result: u64 = 0;
    for (0..(digits.len + 1 - size)) |begin| {
        var product: u64 = 1;
        for (digits[begin..(begin + size)]) |ch| {
            product *= ch -% '0';
        }

        if (result < product) {
            result = product;
        }
    }

    return result;
}
