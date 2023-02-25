pub const NucleotideError = error{Invalid};

pub fn countNucleotides(s: []const u8) NucleotideError![4]u8 {
    var result = [4]u8{ 0, 0, 0, 0 };
    for (s) |c| {
        switch (c) {
            'A' => result[0] += 1,
            'C' => result[1] += 1,
            'G' => result[2] += 1,
            'T' => result[3] += 1,
            else => return NucleotideError.Invalid,
        }
    }
    return result;
}
