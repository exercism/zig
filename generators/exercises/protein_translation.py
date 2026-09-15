from lib import zstr, is_error

HEADER = """const proteins = protein_translation.proteins;
const Protein = protein_translation.Protein;
const TranslationError = protein_translation.TranslationError;

fn testProteinsError(strand: []const u8) !void {
    const actual = proteins(testing.allocator, strand);
    defer if (actual) |slice| testing.allocator.free(slice) else |_| {};
    try testing.expectError(TranslationError.InvalidCodon, actual);
}
"""


def gen_case(case):
    strand = zstr(case["input"]["strand"])
    expected = case["expected"]
    if is_error(expected):
        return f"    try testProteinsError({strand});\n"
    tags = ", ".join("." + p.lower() for p in expected)
    arr = f"[_]Protein{{{tags}}}" if not tags else f"[_]Protein{{ {tags} }}"
    return (
        f"    const expected = {arr};\n"
        f"    const actual = try proteins(testing.allocator, {strand});\n"
        "    defer testing.allocator.free(actual);\n"
        "    try testing.expectEqualSlices(Protein, &expected, actual);\n"
    )
