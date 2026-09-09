const std = @import("std");
const testing = std.testing;

const bowling = @import("bowling.zig");
const Game = bowling.Game;
const Error = bowling.Error;

test "should be able to score a game with all zeros" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(0, game.score());
}

test "should be able to score a game with no strikes or spares" {
    var game = Game.init();
    for ([_]u4{ 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(90, game.score());
}

test "a spare followed by zeros is worth ten points" {
    var game = Game.init();
    for ([_]u4{ 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(10, game.score());
}

test "points scored in the roll after a spare are counted twice" {
    var game = Game.init();
    for ([_]u4{ 6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(16, game.score());
}

test "consecutive spares each get a one roll bonus" {
    var game = Game.init();
    for ([_]u4{ 5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(31, game.score());
}

test "a spare in the last frame gets a one roll bonus that is counted once" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(17, game.score());
}

test "a strike earns ten points in a frame with a single roll" {
    var game = Game.init();
    for ([_]u4{ 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(10, game.score());
}

test "points scored in the two rolls after a strike are counted twice as a bonus" {
    var game = Game.init();
    for ([_]u4{ 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(26, game.score());
}

test "consecutive strikes each get the two roll bonus" {
    var game = Game.init();
    for ([_]u4{ 10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(81, game.score());
}

test "a strike in the last frame gets a two roll bonus that is counted once" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(18, game.score());
}

test "rolling a spare with the two roll bonus does not get a bonus roll" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(20, game.score());
}

test "strikes with the two roll bonus do not get bonus rolls" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(30, game.score());
}

test "last two strikes followed by only last bonus with non strike points" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(31, game.score());
}

test "a strike with the one roll bonus after a spare in the last frame does not get a bonus" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(20, game.score());
}

test "all strikes is a perfect game" {
    var game = Game.init();
    for ([_]u4{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(300, game.score());
}

test "a roll cannot score more than 10 points" {
    var game = Game.init();
    try testing.expectError(Error.PinCountExceeded, game.roll(11));
}

test "two rolls in a frame cannot score more than 10 points" {
    var game = Game.init();
    for ([_]u4{5}) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.PinCountExceeded, game.roll(6));
}

test "bonus roll after a strike in the last frame cannot score more than 10 points" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.PinCountExceeded, game.roll(11));
}

test "two bonus rolls after a strike in the last frame cannot score more than 10 points" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.PinCountExceeded, game.roll(6));
}

test "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectEqual(26, game.score());
}

test "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.PinCountExceeded, game.roll(10));
}

test "second bonus roll after a strike in the last frame cannot score more than 10 points" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.PinCountExceeded, game.roll(11));
}

test "an unstarted game cannot be scored" {
    const game = Game.init();
    try testing.expectError(Error.GameIncomplete, game.score());
}

test "an incomplete game cannot be scored" {
    var game = Game.init();
    for ([_]u4{ 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameIncomplete, game.score());
}

test "cannot roll if game already has ten frames" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameOver, game.roll(0));
}

test "bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameIncomplete, game.score());
}

test "both bonus rolls for a strike in the last frame must be rolled before score can be calculated" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameIncomplete, game.score());
}

test "bonus roll for a spare in the last frame must be rolled before score can be calculated" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameIncomplete, game.score());
}

test "cannot roll after bonus roll for spare" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameOver, game.roll(2));
}

test "cannot roll after bonus rolls for strike" {
    var game = Game.init();
    for ([_]u4{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2 }) |pins| {
        try game.roll(pins);
    }
    try testing.expectError(Error.GameOver, game.roll(2));
}
