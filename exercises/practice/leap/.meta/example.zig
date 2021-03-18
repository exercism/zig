pub fn leap(year: u32) bool {
    const has_factor = (struct {
        const Self = @This();
        y: u32,
        fn has_factor(self: Self, factor: u32) bool {
            return self.y % factor == 0;
        }
    }{ .y = year }).has_factor;

    return has_factor(4) and (!has_factor(100) or has_factor(400));
}
