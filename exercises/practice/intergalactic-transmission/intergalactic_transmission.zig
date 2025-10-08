const std = @import("std");
const mem = std.mem;

pub const TransmissionError = error{
    WrongParity,
};

pub fn transmitSequence(allocator: mem.Allocator, message: []const u8) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = message;
    @compileError("please implement the transmitSequence function");
}

pub fn decodeMessage(allocator: mem.Allocator, message: []const u8) (mem.Allocator.Error || TransmissionError)![]u8 {
    _ = allocator;
    _ = message;
    @compileError("please implement the decodeMessage function");
}
