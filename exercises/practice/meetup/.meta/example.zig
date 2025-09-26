const std = @import("std");

pub const Month = enum {
    january,
    february,
    march,
    april,
    may,
    june,
    july,
    august,
    september,
    october,
    november,
    december,
};

pub const Week = enum {
    first,
    second,
    third,
    fourth,
    teenth,
    last,
};

pub const DayOfWeek = enum {
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
};

fn isLeapYear(year: u12) bool {
    return (year % 4 == 0) and ((year % 100 != 0) or (year % 400 == 0));
}

fn daysInMonth(year: u12, month: Month) u6 {
    return switch (month) {
        .january => 31,
        .february => if (isLeapYear(year)) 29 else 28,
        .march => 31,
        .april => 30,
        .may => 31,
        .june => 30,
        .july => 31,
        .august => 31,
        .september => 30,
        .october => 31,
        .november => 30,
        .december => 31,
    };
}

fn weekConcludes(year: u12, month: Month, week: Week) u6 {
    return switch (week) {
        .first => 7,
        .second => 14,
        .third => 21,
        .fourth => 28,
        .teenth => 19,
        .last => daysInMonth(year, month),
    };
}

fn monthOffset(month: Month) u12 {
    return switch (month) {
        .january => 307, // offset from the end of February of previous year
        .february => 338,
        .march => 1,
        .april => 32,
        .may => 62,
        .june => 93,
        .july => 123,
        .august => 154,
        .september => 185,
        .october => 215,
        .november => 246,
        .december => 276,
    };
}

fn concludingDay(year: u12, month: Month, day_of_month: u6) u12 {
    const y = if (month == .january or month == .february) (year - 1) else year;
    return (y + (y / 4) - (y / 100) + (y / 400) + monthOffset(month) + day_of_month) % 7;
}

pub fn meetupDayOfMonth(year: u12, month: Month, week: Week, day_of_week: DayOfWeek) u12 {
    const day = weekConcludes(year, month, week);
    const concluding = concludingDay(year, month, day);
    const required = @intFromEnum(day_of_week);
    const adjustment: u12 = if (concluding < required) 7 else 0;
    return day + required - (concluding + adjustment);
}

pub fn meetup(year: u12, month: Month, week: Week, day_of_week: DayOfWeek) [10]u8 {
    const day_of_month = meetupDayOfMonth(year, month, week, day_of_week);

    var buffer: [10]u8 = undefined;
    _ = std.fmt.bufPrint(&buffer, "{d:0>4}-{d:0>2}-{d:0>2}", .{ year, 1 + @intFromEnum(month), day_of_month }) catch unreachable;
    return buffer;
}
