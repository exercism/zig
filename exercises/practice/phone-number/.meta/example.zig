pub fn clean(phrase: []const u8) ?[10]u8 {
    var result: [10]u8 = undefined;
    var leading_one = false;
    var index: usize = 0;
    for (phrase) |digit| {
        if (digit < '0') {
            // Ignore whitespace and ( ) + -
            continue;
        }

        if (digit > '9') {
            // Reject letters and punctuation like @
            return null;
        }

        if (index == 0 and digit == '1') {
            if (leading_one) {
                return null;
            }

            leading_one = true;
            continue;
        }

        if (index == 10) {
            return null;
        }

        result[index] = digit;
        index += 1;
    }

    if (index != 10 or result[0] < '2' or result[3] < '2') {
        return null;
    }

    return result;
}
