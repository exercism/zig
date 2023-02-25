pub const NucleotideError = error{Invalid};

pub fn countNucleotides(s: []const u8) NucleotideError![4]u8 {
    _ = s;
    @compileError("please implement the countNucleotides function");
}
