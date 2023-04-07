pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: usize) Classification {
    _ = n;
    @compileError("please implement the classify function");
}
