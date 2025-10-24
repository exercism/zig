const std = @import("std");
const fmt = std.fmt;
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
    state: StopwatchState,
    allocator: mem.Allocator,
    history: std.ArrayList(u32),
    current: u32,

    pub fn init(allocator: mem.Allocator) Stopwatch {
        return .{
            .state = StopwatchState.ready,
            .allocator = allocator,
            .history = std.ArrayList(u32).empty,
            .current = 0,
        };
    }

    pub fn deinit(self: *Stopwatch) void {
        self.history.deinit(self.allocator);
    }

    pub fn currentLap(self: *Stopwatch) [8]u8 {
        return format(self.current);
    }

    pub fn previousLaps(self: *Stopwatch) mem.Allocator.Error![][8]u8 {
        const count = self.history.items.len;
        var result = try self.allocator.alloc([8]u8, count);
        for (0..count) |i| {
            result[i] = format(self.history.items[i]);
        }
        return result;
    }

    pub fn total(self: *Stopwatch) [8]u8 {
        var sum = self.current;
        for (self.history.items) |item| {
            sum += item;
        }
        return format(sum);
    }

    pub fn start(self: *Stopwatch) StopwatchError!void {
        if (self.state == StopwatchState.running) {
            return StopwatchError.AlreadyRunning;
        }
        self.state = StopwatchState.running;
    }

    pub fn stop(self: *Stopwatch) StopwatchError!void {
        if (self.state != StopwatchState.running) {
            return StopwatchError.NotRunning;
        }
        self.state = StopwatchState.stopped;
    }

    pub fn reset(self: *Stopwatch) StopwatchError!void {
        if (self.state != StopwatchState.stopped) {
            return StopwatchError.NotStopped;
        }
        self.state = StopwatchState.ready;
        self.history.clearRetainingCapacity();
        self.current = 0;
    }

    pub fn advanceTime(self: *Stopwatch, by: []const u8) !void {
        if (self.state != StopwatchState.running) {
            return;
        }
        const hours = try std.fmt.parseInt(u32, by[0..2], 10);
        const minutes = try std.fmt.parseInt(u32, by[3..5], 10);
        const seconds = try std.fmt.parseInt(u32, by[6..], 10);
        self.current += 3600 * hours + 60 * minutes + seconds;
    }

    pub fn lap(self: *Stopwatch) (mem.Allocator.Error || StopwatchError)!void {
        if (self.state != StopwatchState.running) {
            return StopwatchError.NotRunning;
        }
        try self.history.append(self.allocator, self.current);
        self.current = 0;
    }
};

fn format(number: u32) [8]u8 {
    const hours = number / 3600;
    const minutes = number % 3600 / 60;
    const seconds = number % 60;
    var buffer: [8]u8 = undefined;
    _ = fmt.bufPrint(&buffer, "{d:0>2}:{d:0>2}:{d:0>2}", .{ hours, minutes, seconds }) catch unreachable;
    return buffer;
}
