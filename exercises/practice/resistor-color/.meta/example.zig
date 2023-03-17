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

const band_colors = [_]ColorBand{
    .black, .brown, .red,    .orange, .yellow,
    .green, .blue,  .violet, .grey,   .white,
};

pub fn colorCode(color: ColorBand) usize {
    return @enumToInt(color);
}

pub fn colors() []const ColorBand {
    return &band_colors;
}
