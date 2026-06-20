IMPORT_SELF = True
HEADER = "const buffer_len = 200; // There are 168 primes under 1000.\n"


def gen_case(case):
    limit = case["input"]["limit"]
    primes = case["expected"]
    elems = [str(p) for p in primes]
    body = ", ".join(elems)
    if not primes:
        expected = "[_]u32{}"
    elif len(body) > 66:
        # Emit 10 per row with a trailing comma; `zig fmt` then right-aligns the
        # columns into a readable grid (a single over-long line otherwise).
        rows = [elems[i : i + 10] for i in range(0, len(elems), 10)]
        grid = "\n".join("    " + ", ".join(row) + "," for row in rows)
        expected = "[_]u32{\n" + grid + "\n}"
    else:
        expected = "[_]u32{ " + body + " }"
    return (
        f"    var buffer: [buffer_len]u32 = undefined;\n"
        f"    const expected = {expected};\n"
        f"    const actual = sieve.primes(&buffer, {limit});\n"
        f"    try testing.expectEqualSlices(u32, &expected, actual);\n"
    )
