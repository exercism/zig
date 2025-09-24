const std = @import("std");
const testing = std.testing;

const robot_simulator = @import("robot_simulator.zig");
const Robot = robot_simulator.Robot;

test "Create robot-at origin facing north" {
    const robot = Robot.init(0, 0, .north);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Create robot-at negative position facing south" {
    const robot = Robot.init(-1, -1, .south);
    try testing.expectEqual(-1, robot.x);
    try testing.expectEqual(-1, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Rotating clockwise-changes north to east" {
    const instructions: []const u8 = "R";
    const robot = Robot.init(0, 0, .north).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Rotating clockwise-changes east to south" {
    const instructions: []const u8 = "R";
    const robot = Robot.init(0, 0, .east).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Rotating clockwise-changes south to west" {
    const instructions: []const u8 = "R";
    const robot = Robot.init(0, 0, .south).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Rotating clockwise-changes west to north" {
    const instructions: []const u8 = "R";
    const robot = Robot.init(0, 0, .west).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Rotating counter-clockwise-changes north to west" {
    const instructions: []const u8 = "L";
    const robot = Robot.init(0, 0, .north).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Rotating counter-clockwise-changes west to south" {
    const instructions: []const u8 = "L";
    const robot = Robot.init(0, 0, .west).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Rotating counter-clockwise-changes south to east" {
    const instructions: []const u8 = "L";
    const robot = Robot.init(0, 0, .south).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Rotating counter-clockwise-changes east to north" {
    const instructions: []const u8 = "L";
    const robot = Robot.init(0, 0, .east).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Moving forward one-facing north increments Y" {
    const instructions: []const u8 = "A";
    const robot = Robot.init(0, 0, .north).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(1, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Moving forward one-facing south decrements Y" {
    const instructions: []const u8 = "A";
    const robot = Robot.init(0, 0, .south).move(instructions);
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(-1, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Moving forward one-facing east increments X" {
    const instructions: []const u8 = "A";
    const robot = Robot.init(0, 0, .east).move(instructions);
    try testing.expectEqual(1, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Moving forward one-facing west decrements X" {
    const instructions: []const u8 = "A";
    const robot = Robot.init(0, 0, .west).move(instructions);
    try testing.expectEqual(-1, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving east and north from README" {
    const instructions: []const u8 = "RAALAL";
    const robot = Robot.init(7, 3, .north).move(instructions);
    try testing.expectEqual(9, robot.x);
    try testing.expectEqual(4, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving west and north" {
    const instructions: []const u8 = "LAAARALA";
    const robot = Robot.init(0, 0, .north).move(instructions);
    try testing.expectEqual(-4, robot.x);
    try testing.expectEqual(1, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving west and south" {
    const instructions: []const u8 = "RRAAAAALA";
    const robot = Robot.init(2, -7, .east).move(instructions);
    try testing.expectEqual(-3, robot.x);
    try testing.expectEqual(-8, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Follow series of instructions-moving east and north" {
    const instructions: []const u8 = "LAAARRRALLLL";
    const robot = Robot.init(8, 4, .south).move(instructions);
    try testing.expectEqual(11, robot.x);
    try testing.expectEqual(5, robot.y);
    try testing.expectEqual(.north, robot.direction);
}
