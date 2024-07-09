pub const SeriesError = error{
    InvalidCharacter,
    NegativeSpan,
    InsufficientDigits,
};

pub fn largestProduct(digits: []const u8, span: i32) SeriesError!u64 {
    _ = digits;
    _ = span;
    @compileError("please implement the largestProduct function");
}
