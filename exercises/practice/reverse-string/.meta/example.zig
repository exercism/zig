const assert = @import("std").debug.assert;

/// Writes a reversed copy of `s` to `buffer`.
/// Asserts `buffer.len >= s.len`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    assert(buffer.len >= s.len);
    for (s, 0..) |c, i| {
        buffer[s.len - 1 - i] = c;
    }
    return buffer[0..s.len];
}
