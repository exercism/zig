HEADER = "const HighScores = high_scores.HighScores;"


def gen_case(case):
    scores = ", ".join(map(str, case["input"]["scores"]))
    prop = case["property"]
    e = case["expected"]
    s = f"    const scores = &[_]i32{{ {scores} }};\n"
    if prop == "latest":
        s += f"    try testing.expectEqual({e}, HighScores.init(scores).latest());\n"
    elif prop == "personalBest":
        s += f"    try testing.expectEqual({e}, HighScores.init(scores).personalBest());\n"
    elif prop == "personalTopThree":
        exp = ", ".join(map(str, e))
        s += f"    try testing.expectEqualSlices(i32, &[_]i32{{ {exp} }}, HighScores.init(scores).personalTopThree());\n"
    return s
