const std = @import("std");
const mem = std.mem;

pub const StopwatchError = error{
    AlreadyRunning,
    NotRunning,
    NotStopped,
};

pub const StopwatchState = enum {
    ready,
    running,
    stopped,
};

pub const Stopwatch = struct {
    // This struct, as well as its fields and methods, needs to be implemented.

    state: StopwatchState,

    pub fn init(allocator: mem.Allocator) Stopwatch {
        _ = allocator;
        @compileError("please implement the init method");
    }

    pub fn deinit(self: *Stopwatch) void {
        _ = self;
        @compileError("please implement the deinit method");
    }

    pub fn currentLap(self: *Stopwatch) [8]u8 {
        _ = self;
        @compileError("please implement the currentLap method");
    }

    pub fn previousLaps(self: *Stopwatch) mem.Allocator.Error![][8]u8 {
        _ = self;
        @compileError("please implement the previousLaps method");
    }

    pub fn total(self: *Stopwatch) [8]u8 {
        _ = self;
        @compileError("please implement the total method");
    }

    pub fn start(self: *Stopwatch) StopwatchError!void {
        _ = self;
        @compileError("please implement the start method");
    }

    pub fn stop(self: *Stopwatch) StopwatchError!void {
        _ = self;
        @compileError("please implement the stop method");
    }

    pub fn reset(self: *Stopwatch) StopwatchError!void {
        _ = self;
        @compileError("please implement the reset method");
    }

    pub fn advanceTime(self: *Stopwatch, by: []const u8) !void {
        _ = self;
        _ = by;
        @compileError("please implement the advanceTime method");
    }

    pub fn lap(self: *Stopwatch) (mem.Allocator.Error || StopwatchError)!void {
        _ = self;
        @compileError("please implement the lap method");
    }
};
