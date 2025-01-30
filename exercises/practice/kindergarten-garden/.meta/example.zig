pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

fn decode(letter: u8) Plant {
    if (letter == 'C') {
        return .clover;
    }
    if (letter == 'G') {
        return .grass;
    }
    if (letter == 'R') {
        return .radishes;
    }
    return .violets;
}

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const first = 2 * (student[0] - 'A');
    const second = first + 1;
    const third = (diagram.len + 1) / 2 + first;
    const fourth = third + 1;
    return .{
        decode(diagram[first]),
        decode(diagram[second]),
        decode(diagram[third]),
        decode(diagram[fourth]),
    };
}
