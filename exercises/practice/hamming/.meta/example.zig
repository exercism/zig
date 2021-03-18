pub const DNAError = error {
    EmptyDNAStrands,
    UnequalDNAStrands,
};

pub fn compute(
    first: []const u8,
    second: []const u8
) DNAError!usize {
    if (first.len == 0 or second.len == 0) {
        return DNAError.EmptyDNAStrands;
    }
    if (first.len != second.len) {
        return DNAError.UnequalDNAStrands;
    }
    var hamming_distance: usize = 0;
    for (first) |rune, i| {
        if (rune != second[i]) {
            hamming_distance += 1;
        }
    }
    return hamming_distance;
}
