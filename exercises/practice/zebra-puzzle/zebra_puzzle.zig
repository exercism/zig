const std = @import("std");
const mem = std.mem;

pub const Nationality = enum {
    englishman,
    japanese,
    norwegian,
    spaniard,
    ukrainian,
};

pub const Color = enum {
    blue,
    green,
    ivory,
    red,
    yellow,
};

pub const Drink = enum {
    coffee,
    milk,
    orange_juice,
    tea,
    water,
};

pub const Hobby = enum {
    reading,
    painting,
    football,
    dancing,
    chess,
};

pub const Pet = enum {
    dog,
    fox,
    horse,
    snails,
    zebra,
};

pub const Solution = struct {
    drinks_water: Nationality,
    owns_zebra: Nationality,
};

pub fn solve(allocator: mem.Allocator) mem.Allocator.Error!Solution {
    _ = allocator;
    @compileError("please implement the solve function");
}
