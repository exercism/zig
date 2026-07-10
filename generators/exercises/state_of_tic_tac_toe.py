from lib import zstr

USE_MEM = False
IMPORT_SELF = True

HEADER = """
const GameState = state_of_tic_tac_toe.GameState;

fn testGameState(board: []const []const u8, expected: GameState) !void {
    const actual = state_of_tic_tac_toe.gameState(board);
    try testing.expectEqual(expected, actual);
}
"""


def gen_case(case):
    rows = case["input"]["board"]
    exp = case["expected"]
    lines = ["    const board = [_][]const u8{"]
    for row in rows:
        lines.append(f"        {zstr(row)}, //")
    lines.append("    };")
    if isinstance(exp, dict) and "error" in exp:
        # An invalid board maps to `.impossible`; note why via the canonical message.
        lines.append(f"    // {exp['error']}")
        lines.append(f"    try testGameState(&board, GameState.impossible);")
    else:
        lines.append(f"    try testGameState(&board, GameState.{exp});")
    return "\n".join(lines) + "\n"
