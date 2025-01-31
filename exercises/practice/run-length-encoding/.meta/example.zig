pub fn encode(buffer: []u8, string: []const u8) []u8 {
    // We process the input string backwards,
    // and reverse our output as our final step.

    var inIndex: usize = string.len;
    var outIndex: usize = 0;
    var runLength: usize = 0;
    while (inIndex > 0) {
        inIndex -= 1;
        const ch = string[inIndex];
        runLength += 1;
        if (inIndex > 0 and ch == string[inIndex - 1]) {
            continue;
        }

        buffer[outIndex] = ch;
        outIndex += 1;
        if (runLength == 1) {
            runLength = 0;
            continue;
        }

        while (runLength > 0) {
            const units: u8 = @intCast(runLength % 10);
            buffer[outIndex] = '0' + units;
            outIndex += 1;
            runLength /= 10;
        }
    }

    // Reverse buffer[0..outIndex]
    var lowIndex: usize = 0;
    var highIndex: usize = outIndex;
    while (lowIndex + 1 < highIndex) {
        highIndex -= 1;
        const a = buffer[lowIndex];
        const b = buffer[highIndex];
        buffer[highIndex] = a;
        buffer[lowIndex] = b;
        lowIndex += 1;
    }

    return buffer[0..outIndex];
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var inIndex: usize = 0;
    var outIndex: usize = 0;
    var runLength: usize = 0;
    while (inIndex < string.len) {
        const ch: u8 = string[inIndex];
        inIndex += 1;
        const units: u8 = ch -% '0';
        if (units <= 9) {
            runLength = runLength * 10 + units;
            continue;
        }

        const endIndex = outIndex + @max(runLength, 1);
        @memset(buffer[outIndex..endIndex], ch);
        outIndex = endIndex;
        runLength = 0;
    }

    return buffer[0..outIndex];
}
