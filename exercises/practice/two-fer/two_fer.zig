pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    _ = buffer;
    _ = name;
    @compileError("respond with the appropriate message given a particular name");
}
