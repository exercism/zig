const std = @import("std");
const testing = std.testing;

const variable_length_quantity = @import("variable_length_quantity.zig");
const encode = variable_length_quantity.encode;
const decode = variable_length_quantity.decode;
const DecodeError = variable_length_quantity.DecodeError;

test "encode - zero" {
    const expected = [_]u8{0};
    const integers = [_]u32{0};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - arbitrary single byte" {
    const expected = [_]u8{64};
    const integers = [_]u32{64};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - asymmetric single byte" {
    const expected = [_]u8{83};
    const integers = [_]u32{83};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - largest single byte" {
    const expected = [_]u8{127};
    const integers = [_]u32{127};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - smallest double byte" {
    const expected = [_]u8{ 129, 0 };
    const integers = [_]u32{128};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - arbitrary double byte" {
    const expected = [_]u8{ 192, 0 };
    const integers = [_]u32{8_192};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - asymmetric double byte" {
    const expected = [_]u8{ 129, 45 };
    const integers = [_]u32{173};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - largest double byte" {
    const expected = [_]u8{ 255, 127 };
    const integers = [_]u32{16_383};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - smallest triple byte" {
    const expected = [_]u8{ 129, 128, 0 };
    const integers = [_]u32{16_384};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - arbitrary triple byte" {
    const expected = [_]u8{ 192, 128, 0 };
    const integers = [_]u32{1_048_576};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - asymmetric triple byte" {
    const expected = [_]u8{ 135, 171, 28 };
    const integers = [_]u32{120_220};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - largest triple byte" {
    const expected = [_]u8{ 255, 255, 127 };
    const integers = [_]u32{2_097_151};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - smallest quadruple byte" {
    const expected = [_]u8{ 129, 128, 128, 0 };
    const integers = [_]u32{2_097_152};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - arbitrary quadruple byte" {
    const expected = [_]u8{ 192, 128, 128, 0 };
    const integers = [_]u32{134_217_728};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - asymmetric quadruple byte" {
    const expected = [_]u8{ 129, 213, 238, 4 };
    const integers = [_]u32{3_503_876};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - largest quadruple byte" {
    const expected = [_]u8{ 255, 255, 255, 127 };
    const integers = [_]u32{268_435_455};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - smallest quintuple byte" {
    const expected = [_]u8{ 129, 128, 128, 128, 0 };
    const integers = [_]u32{268_435_456};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - arbitrary quintuple byte" {
    const expected = [_]u8{ 143, 248, 128, 128, 0 };
    const integers = [_]u32{4_278_190_080};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - asymmetric quintuple byte" {
    const expected = [_]u8{ 136, 179, 149, 194, 5 };
    const integers = [_]u32{2_254_790_917};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - maximum 32-bit integer input" {
    const expected = [_]u8{ 143, 255, 255, 255, 127 };
    const integers = [_]u32{4_294_967_295};
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - two single-byte values" {
    const expected = [_]u8{ 64, 127 };
    const integers = [_]u32{ 64, 127 };
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - two multi-byte values" {
    const expected = [_]u8{ 129, 128, 0, 200, 232, 86 };
    const integers = [_]u32{ 16_384, 1_193_046 };
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "encode - many multi-byte values" {
    const expected = [_]u8{ 192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0 };
    const integers = [_]u32{ 8_192, 1_193_046, 268_435_455, 0, 16_383, 16_384 };
    const actual = try encode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode - one byte" {
    const expected = [_]u32{127};
    const integers = [_]u8{127};
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decode - two bytes" {
    const expected = [_]u32{8_192};
    const integers = [_]u8{ 192, 0 };
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decode - three bytes" {
    const expected = [_]u32{2_097_151};
    const integers = [_]u8{ 255, 255, 127 };
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decode - four bytes" {
    const expected = [_]u32{2_097_152};
    const integers = [_]u8{ 129, 128, 128, 0 };
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decode - maximum 32-bit integer" {
    const expected = [_]u32{4_294_967_295};
    const integers = [_]u8{ 143, 255, 255, 255, 127 };
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}

test "decode - incomplete sequence causes error" {
    const integers = [_]u8{255};
    const actual = decode(testing.allocator, &integers);
    try testing.expectError(DecodeError.IncompleteSequence, actual);
}

test "decode - incomplete sequence causes error, even if value is zero" {
    const integers = [_]u8{128};
    const actual = decode(testing.allocator, &integers);
    try testing.expectError(DecodeError.IncompleteSequence, actual);
}

test "decode - multiple values" {
    const expected = [_]u32{ 8_192, 1_193_046, 268_435_455, 0, 16_383, 16_384 };
    const integers = [_]u8{ 192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0 };
    const actual = try decode(testing.allocator, &integers);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u32, &expected, actual);
}
