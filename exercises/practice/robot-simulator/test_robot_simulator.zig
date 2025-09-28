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
    var robot = Robot.init(0, 0, .north);
    robot.move("R");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Rotating clockwise-changes east to south" {
    var robot = Robot.init(0, 0, .east);
    robot.move("R");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Rotating clockwise-changes south to west" {
    var robot = Robot.init(0, 0, .south);
    robot.move("R");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Rotating clockwise-changes west to north" {
    var robot = Robot.init(0, 0, .west);
    robot.move("R");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Rotating counter-clockwise-changes north to west" {
    var robot = Robot.init(0, 0, .north);
    robot.move("L");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Rotating counter-clockwise-changes west to south" {
    var robot = Robot.init(0, 0, .west);
    robot.move("L");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Rotating counter-clockwise-changes south to east" {
    var robot = Robot.init(0, 0, .south);
    robot.move("L");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Rotating counter-clockwise-changes east to north" {
    var robot = Robot.init(0, 0, .east);
    robot.move("L");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Moving forward one-facing north increments Y" {
    var robot = Robot.init(0, 0, .north);
    robot.move("A");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(1, robot.y);
    try testing.expectEqual(.north, robot.direction);
}

test "Moving forward one-facing south decrements Y" {
    var robot = Robot.init(0, 0, .south);
    robot.move("A");
    try testing.expectEqual(0, robot.x);
    try testing.expectEqual(-1, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Moving forward one-facing east increments X" {
    var robot = Robot.init(0, 0, .east);
    robot.move("A");
    try testing.expectEqual(1, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.east, robot.direction);
}

test "Moving forward one-facing west decrements X" {
    var robot = Robot.init(0, 0, .west);
    robot.move("A");
    try testing.expectEqual(-1, robot.x);
    try testing.expectEqual(0, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving east and north from README" {
    var robot = Robot.init(7, 3, .north);
    robot.move("RAALAL");
    try testing.expectEqual(9, robot.x);
    try testing.expectEqual(4, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving west and north" {
    var robot = Robot.init(0, 0, .north);
    robot.move("LAAARALA");
    try testing.expectEqual(-4, robot.x);
    try testing.expectEqual(1, robot.y);
    try testing.expectEqual(.west, robot.direction);
}

test "Follow series of instructions-moving west and south" {
    var robot = Robot.init(2, -7, .east);
    robot.move("RRAAAAALA");
    try testing.expectEqual(-3, robot.x);
    try testing.expectEqual(-8, robot.y);
    try testing.expectEqual(.south, robot.direction);
}

test "Follow series of instructions-moving east and north" {
    var robot = Robot.init(8, 4, .south);
    robot.move("LAAARRRALLLL");
    try testing.expectEqual(11, robot.x);
    try testing.expectEqual(5, robot.y);
    try testing.expectEqual(.north, robot.direction);
}
