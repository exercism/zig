from lib import zslice


def gen_case(case):
    basket = case["input"]["basket"]
    expected = case["expected"]
    return (
        f"    const basket = {zslice(basket, 'u32')};\n"
        f"    try testing.expectEqual({expected}, book_store.total(basket));\n"
    )
