HEADER = """const Stopwatch = split_second_stopwatch.Stopwatch;
const StopwatchError = split_second_stopwatch.StopwatchError;
const StopwatchState = split_second_stopwatch.StopwatchState;
"""

_ERROR_MAP = {
    "cannot start an already running stopwatch": "AlreadyRunning",
    "cannot stop a stopwatch that is not running": "NotRunning",
    "cannot lap a stopwatch that is not running": "NotRunning",
    "cannot reset a stopwatch that is not stopped": "NotStopped",
}


def _is_error(expected):
    return isinstance(expected, dict) and "error" in expected


def gen_case(case):
    commands = case["input"]["commands"]
    uses_previous = any(c["command"] == "previousLaps" for c in commands)

    out = []
    if uses_previous:
        out.append("var previous: [][8]u8 = undefined;\n")

    for cmd in commands:
        name = cmd["command"]
        expected = cmd.get("expected")

        if name == "new":
            out.append("var stopwatch = Stopwatch.init(testing.allocator);\n")
            out.append("defer stopwatch.deinit();\n")
        elif name == "state":
            out.append(f"try testing.expectEqual(.{expected}, stopwatch.state);\n")
        elif name == "currentLap":
            out.append(
                f'try testing.expectEqualStrings("{expected}", &stopwatch.currentLap());\n'
            )
        elif name == "total":
            out.append(
                f'try testing.expectEqualStrings("{expected}", &stopwatch.total());\n'
            )
        elif name == "advanceTime":
            out.append(f'try stopwatch.advanceTime("{cmd["by"]}");\n')
        elif name == "previousLaps":
            out.append("previous = try stopwatch.previousLaps();\n")
            out.append(f"try testing.expectEqual({len(expected)}, previous.len);\n")
            for i, lap in enumerate(expected):
                out.append(
                    f'try testing.expectEqualStrings("{lap}", &previous[{i}]);\n'
                )
            out.append("testing.allocator.free(previous);\n")
        elif name in ("start", "stop", "reset", "lap"):
            if _is_error(expected):
                err = _ERROR_MAP[expected["error"]]
                out.append(
                    f"try testing.expectError(StopwatchError.{err}, stopwatch.{name}());\n"
                )
            else:
                out.append(f"try stopwatch.{name}();\n")

    return "".join(out)
