from lib import zstr

HEADER = (
    "const Month = meetup.Month;\n"
    "const Week = meetup.Week;\n"
    "const DayOfWeek = meetup.DayOfWeek;\n"
)

_MONTHS = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december",
]


def gen_case(case):
    inp = case["input"]
    year = inp["year"]
    month = _MONTHS[inp["month"] - 1]
    week = inp["week"].lower()
    day = inp["dayofweek"].lower()
    expected = case["expected"]
    return (
        f"    const expected = {zstr(expected)};\n"
        f"    const actual = meetup.meetup({year}, .{month}, .{week}, .{day});\n"
        f"    try testing.expectEqualStrings(expected, &actual);\n"
    )
