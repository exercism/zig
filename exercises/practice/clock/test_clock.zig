const std = @import("std");
const testing = std.testing;

const Clock = @import("clock.zig").Clock;

test "Create a new clock with an initial time-on the hour" {
    const clock = Clock.init(8, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("08:00", &actual);
}

test "Create a new clock with an initial time-past the hour" {
    const clock = Clock.init(11, 9);
    const actual = clock.toString();
    try testing.expectEqualStrings("11:09", &actual);
}

test "Create a new clock with an initial time-midnight is zero hours" {
    const clock = Clock.init(24, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("00:00", &actual);
}

test "Create a new clock with an initial time-hour rolls over" {
    const clock = Clock.init(25, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("01:00", &actual);
}

test "Create a new clock with an initial time-hour rolls over continuously" {
    const clock = Clock.init(100, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("04:00", &actual);
}

test "Create a new clock with an initial time-sixty minutes is next hour" {
    const clock = Clock.init(1, 60);
    const actual = clock.toString();
    try testing.expectEqualStrings("02:00", &actual);
}

test "Create a new clock with an initial time-minutes roll over" {
    const clock = Clock.init(0, 160);
    const actual = clock.toString();
    try testing.expectEqualStrings("02:40", &actual);
}

test "Create a new clock with an initial time-minutes roll over continuously" {
    const clock = Clock.init(0, 1723);
    const actual = clock.toString();
    try testing.expectEqualStrings("04:43", &actual);
}

test "Create a new clock with an initial time-hour and minutes roll over" {
    const clock = Clock.init(25, 160);
    const actual = clock.toString();
    try testing.expectEqualStrings("03:40", &actual);
}

test "Create a new clock with an initial time-hour and minutes roll over continuously" {
    const clock = Clock.init(201, 3001);
    const actual = clock.toString();
    try testing.expectEqualStrings("11:01", &actual);
}

test "Create a new clock with an initial time-hour and minutes roll over to exactly midnight" {
    const clock = Clock.init(72, 8640);
    const actual = clock.toString();
    try testing.expectEqualStrings("00:00", &actual);
}

test "Create a new clock with an initial time-negative hour" {
    const clock = Clock.init(-1, 15);
    const actual = clock.toString();
    try testing.expectEqualStrings("23:15", &actual);
}

test "Create a new clock with an initial time-negative hour rolls over" {
    const clock = Clock.init(-25, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("23:00", &actual);
}

test "Create a new clock with an initial time-negative hour rolls over continuously" {
    const clock = Clock.init(-91, 0);
    const actual = clock.toString();
    try testing.expectEqualStrings("05:00", &actual);
}

test "Create a new clock with an initial time-negative minutes" {
    const clock = Clock.init(1, -40);
    const actual = clock.toString();
    try testing.expectEqualStrings("00:20", &actual);
}

test "Create a new clock with an initial time-negative minutes roll over" {
    const clock = Clock.init(1, -160);
    const actual = clock.toString();
    try testing.expectEqualStrings("22:20", &actual);
}

test "Create a new clock with an initial time-negative minutes roll over continuously" {
    const clock = Clock.init(1, -4820);
    const actual = clock.toString();
    try testing.expectEqualStrings("16:40", &actual);
}

test "Create a new clock with an initial time-negative sixty minutes is previous hour" {
    const clock = Clock.init(2, -60);
    const actual = clock.toString();
    try testing.expectEqualStrings("01:00", &actual);
}

test "Create a new clock with an initial time-negative hour and minutes both roll over" {
    const clock = Clock.init(-25, -160);
    const actual = clock.toString();
    try testing.expectEqualStrings("20:20", &actual);
}

test "Create a new clock with an initial time-negative hour and minutes both roll over continuously" {
    const clock = Clock.init(-121, -5810);
    const actual = clock.toString();
    try testing.expectEqualStrings("22:10", &actual);
}

test "Add minutes-add minutes" {
    var clock = Clock.init(10, 0);
    clock.advance(3);
    const actual = clock.toString();
    try testing.expectEqualStrings("10:03", &actual);
}

test "Add minutes-add no minutes" {
    var clock = Clock.init(6, 41);
    clock.advance(0);
    const actual = clock.toString();
    try testing.expectEqualStrings("06:41", &actual);
}

test "Add minutes-add to next hour" {
    var clock = Clock.init(0, 45);
    clock.advance(40);
    const actual = clock.toString();
    try testing.expectEqualStrings("01:25", &actual);
}

test "Add minutes-add more than one hour" {
    var clock = Clock.init(10, 0);
    clock.advance(61);
    const actual = clock.toString();
    try testing.expectEqualStrings("11:01", &actual);
}

test "Add minutes-add more than two hours with carry" {
    var clock = Clock.init(0, 45);
    clock.advance(160);
    const actual = clock.toString();
    try testing.expectEqualStrings("03:25", &actual);
}

test "Add minutes-add across midnight" {
    var clock = Clock.init(23, 59);
    clock.advance(2);
    const actual = clock.toString();
    try testing.expectEqualStrings("00:01", &actual);
}

test "Add minutes-add more than one day (1500 min = 25 hrs)" {
    var clock = Clock.init(5, 32);
    clock.advance(1500);
    const actual = clock.toString();
    try testing.expectEqualStrings("06:32", &actual);
}

test "Add minutes-add more than two days" {
    var clock = Clock.init(1, 1);
    clock.advance(3500);
    const actual = clock.toString();
    try testing.expectEqualStrings("11:21", &actual);
}

test "Subtract minutes-subtract minutes" {
    var clock = Clock.init(10, 3);
    clock.rewind(3);
    const actual = clock.toString();
    try testing.expectEqualStrings("10:00", &actual);
}

test "Subtract minutes-subtract to previous hour" {
    var clock = Clock.init(10, 3);
    clock.rewind(30);
    const actual = clock.toString();
    try testing.expectEqualStrings("09:33", &actual);
}

test "Subtract minutes-subtract more than an hour" {
    var clock = Clock.init(10, 3);
    clock.rewind(70);
    const actual = clock.toString();
    try testing.expectEqualStrings("08:53", &actual);
}

test "Subtract minutes-subtract across midnight" {
    var clock = Clock.init(0, 3);
    clock.rewind(4);
    const actual = clock.toString();
    try testing.expectEqualStrings("23:59", &actual);
}

test "Subtract minutes-subtract more than two hours" {
    var clock = Clock.init(0, 0);
    clock.rewind(160);
    const actual = clock.toString();
    try testing.expectEqualStrings("21:20", &actual);
}

test "Subtract minutes-subtract more than two hours with borrow" {
    var clock = Clock.init(6, 15);
    clock.rewind(160);
    const actual = clock.toString();
    try testing.expectEqualStrings("03:35", &actual);
}

test "Subtract minutes-subtract more than one day (1500 min = 25 hrs)" {
    var clock = Clock.init(5, 32);
    clock.rewind(1500);
    const actual = clock.toString();
    try testing.expectEqualStrings("04:32", &actual);
}

test "Subtract minutes-subtract more than two days" {
    var clock = Clock.init(2, 20);
    clock.rewind(3000);
    const actual = clock.toString();
    try testing.expectEqualStrings("00:20", &actual);
}

test "Compare two clocks for equality-clocks with same time" {
    const clock1 = Clock.init(15, 37);
    const clock2 = Clock.init(15, 37);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks a minute apart" {
    const clock1 = Clock.init(15, 36);
    const clock2 = Clock.init(15, 37);
    try testing.expect(!clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks an hour apart" {
    const clock1 = Clock.init(14, 37);
    const clock2 = Clock.init(15, 37);
    try testing.expect(!clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with hour overflow" {
    const clock1 = Clock.init(10, 37);
    const clock2 = Clock.init(34, 37);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with hour overflow by several days" {
    const clock1 = Clock.init(3, 11);
    const clock2 = Clock.init(99, 11);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative hour" {
    const clock1 = Clock.init(22, 40);
    const clock2 = Clock.init(-2, 40);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative hour that wraps" {
    const clock1 = Clock.init(17, 3);
    const clock2 = Clock.init(-31, 3);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative hour that wraps multiple times" {
    const clock1 = Clock.init(13, 49);
    const clock2 = Clock.init(-83, 49);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with minute overflow" {
    const clock1 = Clock.init(0, 1);
    const clock2 = Clock.init(0, 1441);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with minute overflow by several days" {
    const clock1 = Clock.init(2, 2);
    const clock2 = Clock.init(2, 4322);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative minute" {
    const clock1 = Clock.init(2, 40);
    const clock2 = Clock.init(3, -20);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative minute that wraps" {
    const clock1 = Clock.init(4, 10);
    const clock2 = Clock.init(5, -1490);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative minute that wraps multiple times" {
    const clock1 = Clock.init(6, 15);
    const clock2 = Clock.init(6, -4305);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative hours and minutes" {
    const clock1 = Clock.init(7, 32);
    const clock2 = Clock.init(-12, -268);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-clocks with negative hours and minutes that wrap" {
    const clock1 = Clock.init(18, 7);
    const clock2 = Clock.init(-54, -11513);
    try testing.expect(clock1.eql(clock2));
}

test "Compare two clocks for equality-full clock and zeroed clock" {
    const clock1 = Clock.init(24, 0);
    const clock2 = Clock.init(0, 0);
    try testing.expect(clock1.eql(clock2));
}
