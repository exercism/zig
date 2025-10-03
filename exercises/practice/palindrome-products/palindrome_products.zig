const std = @import("std");
const mem = std.mem;

pub const Pair = struct {
    first: u64,
    second: u64,
};

pub const Palindrome = struct {
    value: u64,
    factors: []Pair,
};

pub fn smallest(allocator: mem.Allocator, min: u64, max: u64) mem.Allocator.Error!?Palindrome {
    _ = allocator;
    _ = min;
    _ = max;
    @compileError("please implement the smallest function");
}

pub fn largest(allocator: mem.Allocator, min: u64, max: u64) mem.Allocator.Error!?Palindrome {
    _ = allocator;
    _ = min;
    _ = max;
    @compileError("please implement the largest function");
}
