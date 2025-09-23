pub fn combinations(buffer: []u9, sum: usize, size: usize, exclude: u9) []const u9 {
    var index: usize = 0;
    search(buffer, &index, sum, size, exclude, 0, 9);
    return buffer[0..index];
}

pub fn search(buffer: []u9, offset: *usize, sum: usize, size: usize, exclude: u9, bitset: u9, digit: u4) void {
    if (sum == 0 or size == 0 or digit == 0) {
        if (sum == 0 and size == 0) {
            buffer[offset.*] = bitset;
            offset.* += 1;
        }
        return;
    }

    search(buffer, offset, sum, size, exclude, bitset, digit - 1);
    const current = @as(u9, 1) << (digit - 1);
    if (sum >= digit and (exclude & current) == 0) {
        search(buffer, offset, sum - digit, size - 1, exclude, bitset | current, digit - 1);
    }
}
