HEADER = """const solve = zebra_puzzle.solve;
const Nationality = zebra_puzzle.Nationality;"""

# canonical property name -> Solution struct field accessed on the solution
_FIELDS = {
    "drinksWater": "drinks_water",
    "ownsZebra": "owns_zebra",
}


def gen_case(case):
    field = _FIELDS[case["property"]]
    nationality = case["expected"].lower()
    return (
        f"    const expected: Nationality = .{nationality};\n"
        f"    const actual = (try solve(testing.allocator)).{field};\n"
        "    try testing.expectEqual(expected, actual);\n"
    )
