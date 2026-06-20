from lib import zstr

USE_MEM = True

HEADER = """
fn testTranscription(dna: []const u8, expected: []const u8) !void {
    const rna = try rna_transcription.toRna(testing.allocator, dna);
    defer testing.allocator.free(rna);
    try testing.expectEqualStrings(expected, rna);
}"""


def describe(case, parent):
    # The target lowercases the canonical descriptions.
    return case["description"].lower()


def gen_case(case):
    dna = case["input"]["dna"]
    expected = case["expected"]
    return f"    try testTranscription({zstr(dna)}, {zstr(expected)});\n"
