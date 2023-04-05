pub const NucleotideError = error{Invalid};

pub const Nucleotides = struct {
    a: u32,
    c: u32,
    g: u32,
    t: u32,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Nucleotides {
    _ = s;
}
