const std = @import("std");
const testing = std.testing;

const intergalactic_transmission = @import("intergalactic_transmission.zig");
const transmitSequence = intergalactic_transmission.transmitSequence;
const decodeMessage = intergalactic_transmission.decodeMessage;
const TransmissionError = intergalactic_transmission.TransmissionError;

test "calculate transmit sequences-empty message" {
    const message = [_]u8{};
    const expected = [_]u8{};
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0x00 is transmitted as 0x0000" {
    const message = [_]u8{0x00};
    const expected = [_]u8{ 0x00, 0x00 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0x02 is transmitted as 0x0300" {
    const message = [_]u8{0x02};
    const expected = [_]u8{ 0x03, 0x00 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0x06 is transmitted as 0x0600" {
    const message = [_]u8{0x06};
    const expected = [_]u8{ 0x06, 0x00 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0x05 is transmitted as 0x0581" {
    const message = [_]u8{0x05};
    const expected = [_]u8{ 0x05, 0x81 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0x29 is transmitted as 0x2881" {
    const message = [_]u8{0x29};
    const expected = [_]u8{ 0x28, 0x81 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-0xc001c0de is transmitted as 0xc000711be1" {
    const message = [_]u8{ 0xc0, 0x01, 0xc0, 0xde };
    const expected = [_]u8{ 0xc0, 0x00, 0x71, 0x1b, 0xe1 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-six byte message" {
    const message = [_]u8{ 0x47, 0x72, 0x65, 0x61, 0x74, 0x21 };
    const expected = [_]u8{ 0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0x84 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-seven byte message" {
    const message = [_]u8{ 0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21 };
    const expected = [_]u8{ 0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x42 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-eight byte message" {
    const message = [_]u8{ 0xc0, 0x01, 0x13, 0x37, 0xc0, 0xde, 0x21, 0x21 };
    const expected = [_]u8{ 0xc0, 0x00, 0x44, 0x66, 0x7d, 0x06, 0x78, 0x42, 0x21, 0x81 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "calculate transmit sequences-twenty byte message" {
    const message = [_]u8{ 0x45, 0x78, 0x65, 0x72, 0x63, 0x69, 0x73, 0x6d, 0x20, 0x69, 0x73, 0x20, 0x61, 0x77, 0x65, 0x73, 0x6f, 0x6d, 0x65, 0x21 };
    const expected = [_]u8{ 0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90, 0x1b, 0x2e, 0x33, 0x03, 0x84, 0xee, 0x65, 0xb8, 0xdb, 0xed, 0xd7, 0x28, 0x84 };
    const actual = try transmitSequence(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-empty message" {
    const message = [_]u8{};
    const expected = [_]u8{};
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-zero message" {
    const message = [_]u8{ 0x00, 0x00 };
    const expected = [_]u8{0x00};
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-0x0300 is decoded to 0x02" {
    const message = [_]u8{ 0x03, 0x00 };
    const expected = [_]u8{0x02};
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-0x0581 is decoded to 0x05" {
    const message = [_]u8{ 0x05, 0x81 };
    const expected = [_]u8{0x05};
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-0x2881 is decoded to 0x29" {
    const message = [_]u8{ 0x28, 0x81 };
    const expected = [_]u8{0x29};
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-first byte has wrong parity" {
    const message = [_]u8{ 0x07, 0x00 };
    try testing.expectError(TransmissionError.WrongParity, decodeMessage(testing.allocator, &message));
}

test "decode received messages-second byte has wrong parity" {
    const message = [_]u8{ 0x03, 0x68 };
    try testing.expectError(TransmissionError.WrongParity, decodeMessage(testing.allocator, &message));
}

test "decode received messages-0xcf4b00 is decoded to 0xce94" {
    const message = [_]u8{ 0xcf, 0x4b, 0x00 };
    const expected = [_]u8{ 0xce, 0x94 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-0xe2566500 is decoded to 0xe2ad90" {
    const message = [_]u8{ 0xe2, 0x56, 0x65, 0x00 };
    const expected = [_]u8{ 0xe2, 0xad, 0x90 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-six byte message" {
    const message = [_]u8{ 0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0x84 };
    const expected = [_]u8{ 0x47, 0x72, 0x65, 0x61, 0x74, 0x21 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-seven byte message" {
    const message = [_]u8{ 0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x42 };
    const expected = [_]u8{ 0x47, 0x72, 0x65, 0x61, 0x74, 0x31, 0x21 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-last byte has wrong parity" {
    const message = [_]u8{ 0x47, 0xb8, 0x99, 0xac, 0x17, 0xa0, 0xc5, 0x43 };
    try testing.expectError(TransmissionError.WrongParity, decodeMessage(testing.allocator, &message));
}

test "decode received messages-eight byte message" {
    const message = [_]u8{ 0xc0, 0x00, 0x44, 0x66, 0x7d, 0x06, 0x78, 0x42, 0x21, 0x81 };
    const expected = [_]u8{ 0xc0, 0x01, 0x13, 0x37, 0xc0, 0xde, 0x21, 0x21 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-twenty byte message" {
    const message = [_]u8{ 0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90, 0x1b, 0x2e, 0x33, 0x03, 0x84, 0xee, 0x65, 0xb8, 0xdb, 0xed, 0xd7, 0x28, 0x84 };
    const expected = [_]u8{ 0x45, 0x78, 0x65, 0x72, 0x63, 0x69, 0x73, 0x6d, 0x20, 0x69, 0x73, 0x20, 0x61, 0x77, 0x65, 0x73, 0x6f, 0x6d, 0x65, 0x21 };
    const actual = try decodeMessage(testing.allocator, &message);
    defer testing.allocator.free(actual);
    try testing.expectEqualSlices(u8, &expected, actual);
}

test "decode received messages-wrong parity on 16th byte" {
    const message = [_]u8{ 0x44, 0xbd, 0x18, 0xaf, 0x27, 0x1b, 0xa5, 0xe7, 0x6c, 0x90, 0x1b, 0x2e, 0x33, 0x03, 0x84, 0xef, 0x65, 0xb8, 0xdb, 0xed, 0xd7, 0x28, 0x84 };
    try testing.expectError(TransmissionError.WrongParity, decodeMessage(testing.allocator, &message));
}
