pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub const ClassifyError = error{IllegalArgument};

pub fn classify(n: usize) ClassifyError!Classification {
    _ = n;
    @compileError("please implement the classify function");
}
