const std = @import("std");

pub const HighScores = struct {
    scores: []const u32,

    pub fn init(scores: []const u32) HighScores {
        return .{ .scores = scores };
    }

    pub fn latest(self: HighScores) u32 {
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: HighScores) u32 {
        return std.mem.max(u32, self.scores);
    }

    /// Writes (at most) the three highest scores from `self` into `buffer`.
    /// Asserts `buffer.len == self.scores.len`.
    pub fn personalTopThree(self: HighScores, buffer: []u32) []u32 {
        std.debug.assert(buffer.len == self.scores.len);
        std.mem.copy(u32, buffer, self.scores);
        std.mem.sort(u32, buffer, {}, std.sort.desc(u32));
        return buffer[0..@min(buffer.len, 3)];
    }
};
