from lib import zstr

USE_MEM = False
IMPORT_SELF = True

HEADER = """
const GameState = state_of_tic_tac_toe.GameState;
"""


def gen_case(case):
    rows = case["input"]["board"]
    exp = case["expected"]
    lines = ["    const board = [_][]const u8{"]
    for row in rows:
        lines.append(f"        {zstr(row)}, //")
    lines.append("    };")
    lines.append("    const actual = state_of_tic_tac_toe.gameState(&board);")
    if isinstance(exp, dict) and "error" in exp:
        # An invalid board maps to `.impossible`; note why via the canonical message.
        lines.append(f"    // {exp['error']}")
        lines.append("    try testing.expectEqual(GameState.impossible, actual);")
    else:
        lines.append(f"    try testing.expectEqual(GameState.{exp}, actual);")
    return "\n".join(lines) + "\n"
