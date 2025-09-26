const std = @import("std");

pub const RecognitionError = error{
    InvalidRowCount,
    InvalidColumnCount,
};

pub fn convert(buffer: []u8, input: []const []const u8) RecognitionError![]u8 {
    _ = buffer;
    _ = input;
    @compileError("please implement the convert function");
}
