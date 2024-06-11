const std = @import("std");
const mem = std.mem;

pub fn toRoman(allocator: mem.Allocator, arabicNumeral: i16) mem.Allocator.Error![]u8 {
    _ = allocator;
    _ = arabicNumeral;
    @compileError("please implement the toRoman function");
}
