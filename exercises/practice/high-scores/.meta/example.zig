const std = @import("std");

pub const HighScores = struct {
    scores: []const u32,

    pub fn init(s: []const u32) HighScores {
        return .{ .scores = s };
    }

    pub fn latest(self: HighScores) u32 {
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: HighScores) u32 {
        return std.mem.max(u32, self.scores);
    }

    pub fn personalTopThree(self: HighScores, buffer: *[3]u32) []u32 {
        std.debug.assert(self.scores.len <= 100);
        var sorted: [100]u32 = undefined;
        std.mem.copy(u32, &sorted, self.scores);
        std.sort.sort(u32, sorted[0..self.scores.len], {}, std.sort.desc(u32));
        var i = @min(self.scores.len, 3);
        std.mem.copy(u32, buffer, sorted[0..i]);
        return buffer[0..i];
    }
};
