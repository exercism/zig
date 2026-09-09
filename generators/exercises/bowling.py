HEADER = """const Game = bowling.Game;
const Error = bowling.Error;
"""

ERRORS = {
    "Cannot roll after game is over": "GameOver",
    "Pin count exceeds pins on the lane": "PinCountExceeded",
    "Score cannot be taken until the end of the game": "GameIncomplete",
}


def gen_case(case):
    inp = case["input"]
    exp = case["expected"]
    rolls = inp["previousRolls"]

    mutated = rolls or case["property"] == "roll"
    out = f"{'var' if mutated else 'const'} game = Game.init();\n"
    if rolls:
        joined = ", ".join(map(str, rolls))
        out += f"for ([_]u4{{ {joined} }}) |pins| {{\n"
        out += "try game.roll(pins);\n"
        out += "}\n"

    if case["property"] == "roll":
        error = ERRORS[exp["error"]]
        out += f"try testing.expectError(Error.{error}, game.roll({inp['roll']}));\n"
    elif isinstance(exp, dict):
        error = ERRORS[exp["error"]]
        out += f"try testing.expectError(Error.{error}, game.score());\n"
    else:
        out += f"try testing.expectEqual({exp}, game.score());\n"
    return out
