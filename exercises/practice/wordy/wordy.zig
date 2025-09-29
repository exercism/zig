const std = @import("std");

pub const ArgumentError = error{
    UnknownOperation,
    SyntaxError,
    DivisionByZero,
};

pub fn answer(question: []const u8) ArgumentError!i32 {
    _ = question;
    @compileError("please implement the answer function");
}
