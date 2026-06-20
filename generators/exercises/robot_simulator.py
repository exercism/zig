HEADER = """const Robot = robot_simulator.Robot;
"""


def gen_case(case):
    inp = case["input"]
    exp = case["expected"]
    x = inp["position"]["x"]
    y = inp["position"]["y"]
    direction = inp["direction"]
    ex = exp["position"]["x"]
    ey = exp["position"]["y"]
    edir = exp["direction"]

    out = []
    if case["property"] == "create":
        out.append(f"const robot = Robot.init({x}, {y}, .{direction});\n")
        out.append(f"try testing.expectEqual({ex}, robot.x);\n")
        out.append(f"try testing.expectEqual({ey}, robot.y);\n")
        out.append(f"try testing.expectEqual(.{edir}, robot.direction);\n")
        return "".join(out)

    instructions = inp["instructions"]
    out.append(f"var robot = Robot.init({x}, {y}, .{direction});\n")
    out.append(f'robot.move("{instructions}");\n')
    out.append(f"try testing.expectEqual({ex}, robot.x);\n")
    out.append(f"try testing.expectEqual({ey}, robot.y);\n")
    out.append(f"try testing.expectEqual(.{edir}, robot.direction);\n")
    return "".join(out)
