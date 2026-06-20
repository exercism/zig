from lib import zstr, zint, is_error

HEADER = "const countNucleotides = nucleotide_count.countNucleotides;\n"


def gen_case(case):
    strand = case["input"]["strand"]
    expected = case["expected"]
    if is_error(expected):
        return (
            f"    const actual = countNucleotides({zstr(strand)});\n"
            f"    try testing.expectError(nucleotide_count.NucleotideError.Invalid, actual);\n"
        )
    s = f"    const actual = try countNucleotides({zstr(strand)});\n"
    for letter, field in (("A", "a"), ("C", "c"), ("G", "g"), ("T", "t")):
        s += (
            f"    try testing.expectEqual(@as(u32, {zint(expected[letter])}), "
            f"actual.{field});\n"
        )
    return s
