pub const HighScores = struct {
    count: usize,
    top: [3]i32,
    last: i32,

    pub fn init(scores: []const i32) HighScores {
        var count: usize = 0;
        var top: [4]i32 = undefined;
        var last: i32 = undefined;
        for (scores) |score| {
            var index = count;
            while (index > 0 and top[index - 1] < score) {
                top[index] = top[index - 1];
                index -= 1;
            }
            top[index] = score;
            if (count < 3) {
                count += 1;
            }
            last = score;
        }

        var result: HighScores = .{
            .count = count,
            .top = undefined,
            .last = last,
        };
        @memcpy(&result.top, top[0..3]);
        return result;
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.count == 0) {
            return null;
        }
        return self.last;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.count == 0) {
            return null;
        }
        return self.top[0];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top[0..self.count];
    }
};
