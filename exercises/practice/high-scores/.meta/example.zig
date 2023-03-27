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

    pub fn personalTopThree(self: HighScores, buffer: []u32) []u32 {
        std.debug.assert(buffer.len >= self.scores.len);
        std.mem.copy(u32, buffer, self.scores);
        std.sort.sort(u32, buffer, {}, std.sort.desc(u32));
        return buffer[0..@min(buffer.len, 3)];
    }
};
