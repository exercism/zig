IMPORT_SELF = False
HEADER = 'const Clock = @import("clock.zig").Clock;'


def gen_case(case):
    inp = case["input"]
    exp = case["expected"]
    prop = case["property"]

    if prop == "equal":
        clock1 = inp["clock1"]
        clock2 = inp["clock2"]
        bang = "" if exp else "!"
        return (
            f"const clock1 = Clock.init({clock1['hour']}, {clock1['minute']});\n"
            f"const clock2 = Clock.init({clock2['hour']}, {clock2['minute']});\n"
            f"try testing.expect({bang}clock1.eql(clock2));\n"
        )

    if prop == "create":
        out = f"const clock = Clock.init({inp['hour']}, {inp['minute']});\n"
    else:
        method = "advance" if prop == "add" else "rewind"
        out = f"var clock = Clock.init({inp['hour']}, {inp['minute']});\n"
        out += f"clock.{method}({inp['value']});\n"
    out += "const actual = clock.toString();\n"
    out += f'try testing.expectEqualStrings("{exp}", &actual);\n'
    return out
