const std = @import("std");

pub fn total(basket: []const u32) u32 {
    var tally: [5]u32 = .{ 0, 0, 0, 0, 0 };
    for (basket) |book| {
        tally[book - 1] += 1;
    }

    std.mem.sort(u32, &tally, {}, comptime std.sort.desc(u32));

    var five = tally[4];
    var four = tally[3] - tally[4];
    var three = tally[2] - tally[3];
    const two = tally[1] - tally[2];
    const one = tally[0] - tally[1];

    // Two groups of four are cheaper than a group of five plus a group of three.
    const adjustment = @min(three, five);
    five -= adjustment;
    three -= adjustment;
    four += 2 * adjustment;

    return 5 * five * 600 + 4 * four * 640 + 3 * three * 720 + 2 * two * 760 + 1 * one * 800;
}
