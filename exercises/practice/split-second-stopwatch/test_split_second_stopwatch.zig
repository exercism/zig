const std = @import("std");
const testing = std.testing;

const split_second_stopwatch = @import("split_second_stopwatch.zig");
const Stopwatch = split_second_stopwatch.Stopwatch;
const StopwatchError = split_second_stopwatch.StopwatchError;
const StopwatchState = split_second_stopwatch.StopwatchState;

test "new stopwatch starts in ready state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectEqual(.ready, stopwatch.state);
}

test "new stopwatch's current lap has no elapsed time" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectEqualStrings("00:00:00", &stopwatch.currentLap());
}

test "new stopwatch's total has no elapsed time" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectEqualStrings("00:00:00", &stopwatch.total());
}

test "new stopwatch does not have previous laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(0, previous.len);
    testing.allocator.free(previous);
}

test "start from ready state changes state to running" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try testing.expectEqual(.running, stopwatch.state);
}

test "start does not change previous laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(0, previous.len);
    testing.allocator.free(previous);
}

test "start initiates time tracking for current lap" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:05");
    try testing.expectEqualStrings("00:00:05", &stopwatch.currentLap());
}

test "start initiates time tracking for total" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:23");
    try testing.expectEqualStrings("00:00:23", &stopwatch.total());
}

test "start cannot be called from running state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try testing.expectError(StopwatchError.AlreadyRunning, stopwatch.start());
}

test "stop from running state changes state to stopped" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.stop();
    try testing.expectEqual(.stopped, stopwatch.state);
}

test "stop pauses time tracking for current lap" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:05");
    try stopwatch.stop();
    try stopwatch.advanceTime("00:00:08");
    try testing.expectEqualStrings("00:00:05", &stopwatch.currentLap());
}

test "stop pauses time tracking for total" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:13");
    try stopwatch.stop();
    try stopwatch.advanceTime("00:00:44");
    try testing.expectEqualStrings("00:00:13", &stopwatch.total());
}

test "stop cannot be called from ready state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectError(StopwatchError.NotRunning, stopwatch.stop());
}

test "stop cannot be called from stopped state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.stop();
    try testing.expectError(StopwatchError.NotRunning, stopwatch.stop());
}

test "start from stopped state changes state to running" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.stop();
    try stopwatch.start();
    try testing.expectEqual(.running, stopwatch.state);
}

test "start from stopped state resumes time tracking for current lap" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:01:20");
    try stopwatch.stop();
    try stopwatch.advanceTime("00:00:20");
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:08");
    try testing.expectEqualStrings("00:01:28", &stopwatch.currentLap());
}

test "start from stopped state resumes time tracking for total" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:23");
    try stopwatch.stop();
    try stopwatch.advanceTime("00:00:44");
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:09");
    try testing.expectEqualStrings("00:00:32", &stopwatch.total());
}

test "lap adds current lap to previous laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:01:38");
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(1, previous.len);
    try testing.expectEqualStrings("00:01:38", &previous[0]);
    testing.allocator.free(previous);
    try stopwatch.advanceTime("00:00:44");
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(2, previous.len);
    try testing.expectEqualStrings("00:01:38", &previous[0]);
    try testing.expectEqualStrings("00:00:44", &previous[1]);
    testing.allocator.free(previous);
}

test "lap resets current lap and resumes time tracking" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:08:22");
    try stopwatch.lap();
    try testing.expectEqualStrings("00:00:00", &stopwatch.currentLap());
    try stopwatch.advanceTime("00:00:15");
    try testing.expectEqualStrings("00:00:15", &stopwatch.currentLap());
}

test "lap continues time tracking for total" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:22");
    try stopwatch.lap();
    try stopwatch.advanceTime("00:00:33");
    try testing.expectEqualStrings("00:00:55", &stopwatch.total());
}

test "lap cannot be called from ready state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectError(StopwatchError.NotRunning, stopwatch.lap());
}

test "lap cannot be called from stopped state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.stop();
    try testing.expectError(StopwatchError.NotRunning, stopwatch.lap());
}

test "stop does not change previous laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:11:22");
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(1, previous.len);
    try testing.expectEqualStrings("00:11:22", &previous[0]);
    testing.allocator.free(previous);
    try stopwatch.stop();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(1, previous.len);
    try testing.expectEqualStrings("00:11:22", &previous[0]);
    testing.allocator.free(previous);
}

test "reset from stopped state changes state to ready" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.stop();
    try stopwatch.reset();
    try testing.expectEqual(.ready, stopwatch.state);
}

test "reset resets current lap" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:10");
    try stopwatch.stop();
    try stopwatch.reset();
    try testing.expectEqualStrings("00:00:00", &stopwatch.currentLap());
}

test "reset clears previous laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("00:00:10");
    try stopwatch.lap();
    try stopwatch.advanceTime("00:00:20");
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(2, previous.len);
    try testing.expectEqualStrings("00:00:10", &previous[0]);
    try testing.expectEqualStrings("00:00:20", &previous[1]);
    testing.allocator.free(previous);
    try stopwatch.stop();
    try stopwatch.reset();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(0, previous.len);
    testing.allocator.free(previous);
}

test "reset cannot be called from ready state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try testing.expectError(StopwatchError.NotStopped, stopwatch.reset());
}

test "reset cannot be called from running state" {
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try testing.expectError(StopwatchError.NotStopped, stopwatch.reset());
}

test "supports very long laps" {
    var previous: [][8]u8 = undefined;
    var stopwatch = Stopwatch.init(testing.allocator);
    defer stopwatch.deinit();
    try stopwatch.start();
    try stopwatch.advanceTime("01:23:45");
    try testing.expectEqualStrings("01:23:45", &stopwatch.currentLap());
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(1, previous.len);
    try testing.expectEqualStrings("01:23:45", &previous[0]);
    testing.allocator.free(previous);
    try stopwatch.advanceTime("04:01:40");
    try testing.expectEqualStrings("04:01:40", &stopwatch.currentLap());
    try testing.expectEqualStrings("05:25:25", &stopwatch.total());
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(2, previous.len);
    try testing.expectEqualStrings("01:23:45", &previous[0]);
    try testing.expectEqualStrings("04:01:40", &previous[1]);
    testing.allocator.free(previous);
    try stopwatch.advanceTime("08:43:05");
    try testing.expectEqualStrings("08:43:05", &stopwatch.currentLap());
    try testing.expectEqualStrings("14:08:30", &stopwatch.total());
    try stopwatch.lap();
    previous = try stopwatch.previousLaps();
    try testing.expectEqual(3, previous.len);
    try testing.expectEqualStrings("01:23:45", &previous[0]);
    try testing.expectEqualStrings("04:01:40", &previous[1]);
    try testing.expectEqualStrings("08:43:05", &previous[2]);
    testing.allocator.free(previous);
}
