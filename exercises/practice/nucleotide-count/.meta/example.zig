pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32 = 0,
    c: u32 = 0,
    g: u32 = 0,
    t: u32 = 0,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var result = Counts{};
    for (s) |c| {
        switch (c) {
            'A' => result.a += 1,
            'C' => result.c += 1,
            'G' => result.g += 1,
            'T' => result.t += 1,
            else => return NucleotideError.Invalid,
        }
    }
    return result;
}
