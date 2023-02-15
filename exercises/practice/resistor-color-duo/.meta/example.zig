pub const ColorBand = enum(u4) {
    black,
    brown,
    red,
    orange,
    yellow,
    green,
    blue,
    violet,
    grey,
    white,
};

pub const RuntimeError = error{
    IllegalArgument,
};

pub fn colorCode(colors: []const ColorBand) RuntimeError!isize {
    if (colors.len < 2) {
        return RuntimeError.IllegalArgument;
    }
    return @as(isize, @enumToInt(colors[0])) * 10 + @as(isize, @enumToInt(colors[1]));
}
