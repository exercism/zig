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

pub fn colorCode(colors: [2]ColorBand) usize {
    return @as(usize, @enumToInt(colors[0])) * 10 + @as(usize, @enumToInt(colors[1]));
}
