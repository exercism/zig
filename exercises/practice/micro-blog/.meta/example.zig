pub fn truncate(phrase: []const u8) []const u8 {
    var index: usize = 0;
    var remaining: usize = 6;
    while (index < phrase.len) {
        if (phrase[index] & 0xc0 != 0x80) {
            remaining -= 1;
            if (remaining == 0) {
                // start of 6th character
                break;
            }
        }
        index += 1;
    }

    return phrase[0..index];
}
